import { redirect } from "next/navigation";
import { ambilPeranSaya } from "@/lib/sesi";

export default async function Halaman() {
  const { peran } = await ambilPeranSaya();
  redirect(peran ? "/beranda" : "/masuk");
}
