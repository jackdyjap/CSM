"use client";

import { Tombol } from "./ui";

export function TombolCetak({ teks = "Cetak" }: { teks?: string }) {
  return (
    <Tombol type="button" onClick={() => window.print()}>
      {teks}
    </Tombol>
  );
}
