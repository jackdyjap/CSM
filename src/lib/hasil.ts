// Bentuk hasil yang dikembalikan setiap aksi formulir.
export type HasilAksi = {
  galat?: string;
  sukses?: string;
  /** Tautan yang perlu dibagikan (undangan / atur ulang kata sandi). */
  tautan?: string;
  /** Teks pesan WhatsApp yang menyertai tautan. */
  teksWa?: string;
  /**
   * Halaman yang dibuka setelah aksi berhasil, dengan muat ulang penuh.
   * Dipakai sebagai pengganti redirect() di aksi supaya halaman tujuan
   * dimuat bersih (mis. Beranda setelah Atur profil atau pendaftaran).
   */
  lanjut?: string;
};

export type AksiForm = (sebelumnya: HasilAksi, formData: FormData) => Promise<HasilAksi>;
