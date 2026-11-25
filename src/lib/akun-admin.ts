import "server-only";
import type { buatClientServer } from "@/lib/supabase/server";

// Data akun untuk halaman Admin → Akun & peran (daftar ringkas dan detail).

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

export const NAMA_PERAN = { admin: "Admin", ketua_tim: "Ketua Tim", pemimpin: "Pemimpin" } as const;

type Tim = { id: string; nama: string };
type Kelompok = { id: string; nama: string; tim: Tim | null };

export type AkunAdmin = {
  id: string;
  nama_tampilan: string;
  login: string | null;
  nama_pengguna: string | null;
  email: string | null;
  nomor_hp: string | null;
  anggota_id: string | null;
  anggota: { kelompok: Kelompok | null } | null;
  penugasan_peran: {
    id: string;
    peran: keyof typeof NAMA_PERAN;
    jabatan: "pemimpin" | "wakil" | null;
    tim: Tim | null;
    kelompok: Kelompok | null;
  }[];
};

const KOLOM =
  "id, nama_tampilan, login, nama_pengguna, email, nomor_hp, anggota_id, " +
  "anggota:anggota!akun_anggota_fk(kelompok(id, nama, tim(id, nama))), " +
  "penugasan_peran(id, peran, jabatan, tim(id, nama), kelompok(id, nama, tim(id, nama)))";

export async function ambilSemuaAkun(supabase: Supabase) {
  const { data } = await supabase.from("akun").select(KOLOM).order("nama_tampilan");
  // Relasi satu-ke-satu dikembalikan Supabase sebagai objek tunggal.
  return (data ?? []) as unknown as AkunAdmin[];
}

export async function ambilAkun(supabase: Supabase, akunId: string) {
  const { data } = await supabase.from("akun").select(KOLOM).eq("id", akunId).maybeSingle();
  return (data ?? null) as unknown as AkunAdmin | null;
}

/** Label satu penugasan, mis. "Wakil · Kelompok Betel (HG 1)". */
export function labelPenugasan(p: AkunAdmin["penugasan_peran"][number]) {
  const nama = p.peran === "pemimpin" && p.jabatan === "wakil" ? "Wakil" : NAMA_PERAN[p.peran];
  if (p.kelompok) return `${nama} · ${p.kelompok.nama}${p.kelompok.tim ? ` (${p.kelompok.tim.nama})` : ""}`;
  if (p.tim) return `${nama} · Tim ${p.tim.nama}`;
  return nama;
}

// ---------------------------------------------------------------- Daftar dikelompokkan

/** Satu baris di daftar ringkas (data polos, dikirim ke komponen peramban). */
export type BarisDaftar = { id: string; nama: string; login: string; label: string; cari: string };
export type BagianDaftar = { judul: string | null; akun: BarisDaftar[] };
export type KelompokDaftar = { kunci: string; judul: string; bagian: BagianDaftar[] };

const urut = (a: string, b: string) => a.localeCompare(b, "id", { sensitivity: "base" });

/**
 * Menyusun akun per tim lalu per kelompok (A→Z). Akun yang terhubung ke
 * beberapa tempat muncul di setiap tempat itu. Akun tanpa tim/kelompok
 * (termasuk Admin yang tidak memegang tim/kelompok) di kelompok paling atas.
 */
export function susunDaftarAkun(akun: AkunAdmin[]): KelompokDaftar[] {
  const tanpa: BarisDaftar[] = [];
  const perTim = new Map<string, { nama: string; pengurus: BarisDaftar[]; kelompok: Map<string, { nama: string; akun: BarisDaftar[] }> }>();

  const timDari = (t: Tim | null) => {
    const kunci = t?.id ?? "-";
    let x = perTim.get(kunci);
    if (!x) {
      x = { nama: t?.nama ?? "Tanpa tim", pengurus: [], kelompok: new Map() };
      perTim.set(kunci, x);
    }
    return x;
  };

  for (const a of akun) {
    const admin = a.penugasan_peran.some((p) => p.peran === "admin");
    const tambahan = admin ? " · Admin" : "";
    const dasarCari = [a.nama_tampilan, a.login, a.nama_pengguna, a.email, a.nomor_hp].filter(Boolean).join(" ");
    const baris = (label: string, tempat: string): BarisDaftar => ({
      id: a.id,
      nama: a.nama_tampilan,
      login: a.login ?? "-",
      label: label + tambahan,
      cari: `${dasarCari} ${tempat} ${label}${tambahan}`.toLowerCase(),
    });

    // Peran di tiap kelompok: anggota, pemimpin, wakil (bisa lebih dari satu).
    const diKelompok = new Map<string, { k: Kelompok; peran: string[] }>();
    const kel = a.anggota?.kelompok;
    if (kel) diKelompok.set(kel.id, { k: kel, peran: ["Anggota"] });
    for (const p of a.penugasan_peran) {
      if (p.peran !== "pemimpin" || !p.kelompok) continue;
      const x = diKelompok.get(p.kelompok.id) ?? { k: p.kelompok, peran: [] };
      x.peran.unshift(p.jabatan === "wakil" ? "Wakil" : "Pemimpin");
      diKelompok.set(p.kelompok.id, x);
    }
    for (const { k, peran } of diKelompok.values()) {
      const t = timDari(k.tim);
      const isi = t.kelompok.get(k.id) ?? { nama: k.nama, akun: [] };
      isi.akun.push(baris(peran.join(" · "), `${t.nama} ${k.nama}`));
      t.kelompok.set(k.id, isi);
    }

    const ketua = a.penugasan_peran.filter((p) => p.peran === "ketua_tim" && p.tim);
    for (const p of ketua) {
      const t = timDari(p.tim);
      t.pengurus.push(baris("Ketua Tim", t.nama));
    }

    if (diKelompok.size === 0 && ketua.length === 0) {
      tanpa.push(baris(admin ? "" : "Tanpa peran", "belum ada tim kelompok"));
    }
  }

  const hasil: KelompokDaftar[] = [];
  const rapikanLabel = (b: BarisDaftar) => ({ ...b, label: b.label.replace(/^ · /, "") });
  if (tanpa.length) {
    hasil.push({ kunci: "tanpa", judul: "Belum ada tim/kelompok", bagian: [{ judul: null, akun: tanpa.map(rapikanLabel) }] });
  }
  const urutAkun = (x: BarisDaftar[]) => [...x].sort((p, q) => urut(p.nama, q.nama));
  for (const [kunci, t] of [...perTim.entries()].sort(([, a], [, b]) => urut(a.nama, b.nama))) {
    const bagian: BagianDaftar[] = [];
    if (t.pengurus.length) bagian.push({ judul: "Pengurus tim", akun: urutAkun(t.pengurus) });
    for (const k of [...t.kelompok.values()].sort((a, b) => urut(a.nama, b.nama))) {
      bagian.push({ judul: `Kelompok ${k.nama}`, akun: urutAkun(k.akun) });
    }
    hasil.push({ kunci, judul: `Tim ${t.nama}`, bagian });
  }
  return hasil;
}
