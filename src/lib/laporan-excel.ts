import "server-only";
import ExcelJS from "exceljs";
import { DIMENSI, persen, type Laporan, type Pilihan } from "@/lib/laporan";
import { hariIniWib } from "@/lib/profil";

/** Berkas Excel laporan demografi: Ringkasan + tabel silang (jumlah dan persen). */
export async function buatExcelLaporan(laporan: Laporan, pilihan: Pilihan, judul: string) {
  const wb = new ExcelJS.Workbook();
  wb.creator = "Absensi Kelompok Kecil";
  wb.created = new Date();
  const tebal = { bold: true } as const;

  // Lembar 1: ringkasan
  const r = wb.addWorksheet("Ringkasan");
  r.addRow([`Laporan demografi: ${judul}`]).font = { bold: true, size: 13 };
  r.addRow([`Dibuat ${hariIniWib()}. Persentase dihitung dari yang sudah mengisi; "Belum diisi" tidak dihitung.`]);
  r.addRow([]);
  r.addRow([DIMENSI[pilihan.dimensi], "Jumlah", "Persen"]).font = tebal;
  for (const k of laporan.kategori) r.addRow([k.label, k.total, k.persen / 100]);
  r.addRow(["Total terisi", laporan.terisi, laporan.terisi ? 1 : 0]).font = tebal;
  r.addRow(["Belum diisi", laporan.belum, null]);
  r.getColumn(1).width = 28;
  r.getColumn(2).width = 10;
  r.getColumn(3).width = 10;
  r.getColumn(3).numFmt = "0.0%";

  // Lembar 2: tabel silang (kategori × kelompok)
  for (const [nama, mode] of [["Tabel silang (jumlah)", "jumlah"], ["Tabel silang (persen)", "persen"]] as const) {
    const t = wb.addWorksheet(nama);
    t.addRow([judul]).font = tebal;
    t.addRow([]);
    t.addRow(["Tim", "", ...laporan.kelompok.map((k) => k.tim), ""]).font = { italic: true };
    t.addRow([DIMENSI[pilihan.dimensi], "", ...laporan.kelompok.map((k) => k.nama), "Total"]).font = tebal;
    for (const kat of laporan.kategori) {
      t.addRow([
        kat.label,
        "",
        ...laporan.kelompok.map((k) =>
          mode === "jumlah" ? (k.jumlah.get(kat.kunci) ?? 0) : persen(k.jumlah.get(kat.kunci) ?? 0, k.terisi) / 100,
        ),
        mode === "jumlah" ? kat.total : kat.persen / 100,
      ]);
    }
    t.addRow(["Total terisi", "", ...laporan.kelompok.map((k) => (mode === "jumlah" ? k.terisi : k.terisi ? 1 : 0)), mode === "jumlah" ? laporan.terisi : 1]).font = tebal;
    t.addRow(["Belum diisi", "", ...laporan.kelompok.map((k) => (mode === "jumlah" ? k.belum : null)), mode === "jumlah" ? laporan.belum : null]);
    t.getColumn(1).width = 28;
    t.getColumn(2).width = 2;
    for (let i = 3; i <= laporan.kelompok.length + 3; i++) {
      t.getColumn(i).width = 16;
      if (mode === "persen") t.getColumn(i).numFmt = "0.0%";
    }
    t.views = [{ state: "frozen", xSplit: 2, ySplit: 4 }];
  }

  return wb.xlsx.writeBuffer();
}
