// Bentuk hasil yang dikembalikan setiap aksi formulir.
export type HasilAksi = {
  galat?: string;
  sukses?: string;
  /** Tautan yang perlu dibagikan (undangan / atur ulang kata sandi). */
  tautan?: string;
  /** Teks pesan WhatsApp yang menyertai tautan. */
  teksWa?: string;
};

export type AksiForm = (sebelumnya: HasilAksi, formData: FormData) => Promise<HasilAksi>;
