"use client";

import { useActionState } from "react";
import { Isian, Pesan, Tombol } from "@/components/ui";
import type { HasilAksi } from "@/lib/hasil";
import { PANJANG_SANDI_MINIMAL } from "@/lib/identitas";
import { aturUlangSandi } from "./aksi";

export function FormAturUlang({ token }: { token: string }) {
  const [hasil, aksi, sedangProses] = useActionState<HasilAksi, FormData>(
    aturUlangSandi.bind(null, token),
    {},
  );

  return (
    <form action={aksi}>
      {hasil.galat ? <Pesan jenis="galat">{hasil.galat}</Pesan> : null}
      <Isian
        label="Kata sandi baru"
        name="sandi"
        type="password"
        minLength={PANJANG_SANDI_MINIMAL}
        autoComplete="new-password"
        keterangan={`Minimal ${PANJANG_SANDI_MINIMAL} karakter.`}
        required
      />
      <Isian
        label="Ulangi kata sandi baru"
        name="sandi_ulang"
        type="password"
        minLength={PANJANG_SANDI_MINIMAL}
        autoComplete="new-password"
        required
      />
      <Tombol type="submit" disabled={sedangProses} className="w-full">
        {sedangProses ? "Menyimpan…" : "Simpan kata sandi baru"}
      </Tombol>
    </form>
  );
}
