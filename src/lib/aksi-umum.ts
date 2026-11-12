"use server";

import { redirect } from "next/navigation";
import { buatClientServer } from "@/lib/supabase/server";

export async function keluar() {
  const supabase = await buatClientServer();
  await supabase.auth.signOut();
  redirect("/masuk");
}
