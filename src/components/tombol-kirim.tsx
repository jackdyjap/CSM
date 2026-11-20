"use client";

import type { ComponentProps } from "react";
import { useFormStatus } from "react-dom";
import { Tombol } from "./ui";

/** Tombol kirim untuk formulir biasa: nonaktif dan berganti teks selama diproses. */
export function TombolKirim({
  children,
  teksProses = "Memproses…",
  ...props
}: ComponentProps<typeof Tombol> & { teksProses?: string }) {
  const { pending } = useFormStatus();
  return (
    <Tombol type="submit" disabled={pending || props.disabled} {...props}>
      {pending ? teksProses : children}
    </Tombol>
  );
}
