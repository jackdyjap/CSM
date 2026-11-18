import { Isian } from "./ui";

/** Tiga isian cara masuk: nama pengguna, email, nomor HP (minimal satu diisi). */
export function IsianLogin({
  awal,
  keterangan = "Isi minimal satu. Masuk ke aplikasi cukup dengan salah satunya.",
}: {
  awal?: { nama_pengguna?: string | null; email?: string | null; nomor_hp?: string | null };
  keterangan?: string;
}) {
  return (
    <fieldset className="mb-1">
      <legend className="mb-2 text-sm opacity-70">{keterangan}</legend>
      <Isian
        label="Nama pengguna"
        name="nama_pengguna"
        defaultValue={awal?.nama_pengguna ?? ""}
        autoComplete="username"
        autoCapitalize="none"
        spellCheck={false}
        placeholder="contoh: budi.santoso"
        keterangan="3–30 karakter: huruf kecil, angka, titik, atau garis bawah; diawali huruf."
      />
      <Isian
        label="Email"
        name="email"
        type="email"
        defaultValue={awal?.email ?? ""}
        autoComplete="email"
        placeholder="nama@gmail.com"
      />
      <Isian
        label="Nomor HP"
        name="nomor_hp"
        type="tel"
        inputMode="tel"
        defaultValue={awal?.nomor_hp ?? ""}
        autoComplete="tel"
        placeholder="081234567890"
      />
    </fieldset>
  );
}
