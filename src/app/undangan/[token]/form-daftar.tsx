"use client";

import { useActionState } from "react";
import { IsianLogin } from "@/components/isian-login";
import { IsianSandi } from "@/components/isian-sandi";
import { Isian, Pesan, Tombol } from "@/components/ui";
import type { HasilAksi } from "@/lib/hasil";
import { PANJANG_SANDI_MINIMAL } from "@/lib/identitas";
import { daftarLewatUndangan } from "./aksi";

export function FormDaftar({ token, namaAwal }: { token: string; namaAwal: string }) {
  const [hasil, aksi, sedangProses] = useActionState<HasilAksi, FormData>(
    daftarLewatUndangan.bind(null, token),
    {},
  );

  return (
    <form action={aksi}>
      {hasil.galat ? <Pesan jenis="galat">{hasil.galat}</Pesan> : null}
      <Isian label="Nama lengkap" name="nama" defaultValue={namaAwal} autoComplete="name" required />
      <IsianLogin keterangan="Cara masuk ke aplikasi: isi minimal satu. Nanti cukup masuk dengan salah satunya." />
      <IsianSandi
        label="Buat kata sandi"
        name="sandi"
        minLength={PANJANG_SANDI_MINIMAL}
        autoComplete="new-password"
        keterangan={`Minimal ${PANJANG_SANDI_MINIMAL} karakter.`}
        required
      />
      <IsianSandi
        label="Ulangi kata sandi"
        name="sandi_ulang"
        minLength={PANJANG_SANDI_MINIMAL}
        autoComplete="new-password"
        required
      />
      <Tombol type="submit" disabled={sedangProses} className="w-full">
        {sedangProses ? "Sedang membuat akun…" : "Buat akun"}
      </Tombol>
    </form>
  );
}
