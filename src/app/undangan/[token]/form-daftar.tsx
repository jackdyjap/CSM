"use client";

import { useActionState } from "react";
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
      <Isian
        label="Email atau nomor HP"
        name="identitas"
        autoComplete="username"
        placeholder="nama@gmail.com atau 081234567890"
        keterangan="Dipakai setiap kali masuk ke aplikasi."
        required
      />
      <Isian
        label="Buat kata sandi"
        name="sandi"
        type="password"
        minLength={PANJANG_SANDI_MINIMAL}
        autoComplete="new-password"
        keterangan={`Minimal ${PANJANG_SANDI_MINIMAL} karakter.`}
        required
      />
      <Isian
        label="Ulangi kata sandi"
        name="sandi_ulang"
        type="password"
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
