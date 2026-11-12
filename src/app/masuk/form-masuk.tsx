"use client";

import Link from "next/link";
import { useActionState } from "react";
import { Isian, Pesan, Tombol } from "@/components/ui";
import { masuk, type HasilMasuk } from "./aksi";

export function FormMasuk() {
  const [hasil, aksi, sedangProses] = useActionState<HasilMasuk, FormData>(masuk, {});

  return (
    <form action={aksi}>
      {hasil.galat ? <Pesan jenis="galat">{hasil.galat}</Pesan> : null}
      <Isian
        label="Email atau nomor HP"
        name="identitas"
        autoComplete="username"
        inputMode="email"
        defaultValue={hasil.identitas}
        placeholder="nama@gmail.com atau 081234567890"
        required
      />
      <Isian label="Kata sandi" name="sandi" type="password" autoComplete="current-password" required />
      <Tombol type="submit" disabled={sedangProses} className="w-full">
        {sedangProses ? "Sedang masuk…" : "Masuk"}
      </Tombol>
      <p className="mt-4 text-center text-sm">
        <Link href="/lupa-sandi" className="underline">
          Lupa kata sandi?
        </Link>
      </p>
    </form>
  );
}
