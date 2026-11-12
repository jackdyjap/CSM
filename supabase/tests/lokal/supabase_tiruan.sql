-- =====================================================================
-- TIRUAN SUPABASE — HANYA untuk pengujian di PostgreSQL biasa.
-- JANGAN dijalankan di proyek Supabase sungguhan (di sana semua ini
-- sudah tersedia).
-- Meniru: peran anon/authenticated/service_role, auth.users, auth.uid(),
-- ruang extensions, dan Supabase Storage (buckets/objects/foldername).
-- =====================================================================

create role anon nologin noinherit;
create role authenticated nologin noinherit;
create role service_role nologin noinherit bypassrls;

create schema extensions;
grant usage on schema extensions to anon, authenticated, service_role;

-- Hak bawaan Supabase: tabel/fungsi baru di public otomatis bisa diakses
-- anon dan authenticated (karena itu migrasi kita mencabutnya secara eksplisit).
grant usage on schema public to anon, authenticated, service_role;
alter default privileges in schema public grant all on tables    to anon, authenticated, service_role;
alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
alter default privileges in schema public grant all on functions to anon, authenticated, service_role;

-- Auth
create schema auth;
grant usage on schema auth to anon, authenticated, service_role;
create table auth.users (
  id    uuid primary key default gen_random_uuid(),
  email text unique,
  phone text unique,
  raw_user_meta_data jsonb default '{}'::jsonb
);
create function auth.uid() returns uuid language sql stable as $$
  select coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;
grant execute on function auth.uid() to anon, authenticated, service_role;

-- Storage
create schema storage;
grant usage on schema storage to anon, authenticated, service_role;
create table storage.buckets (
  id                 text primary key,
  name               text not null,
  public             boolean default false,
  file_size_limit    bigint,
  allowed_mime_types text[]
);
create table storage.objects (
  id         uuid primary key default gen_random_uuid(),
  bucket_id  text references storage.buckets(id),
  name       text not null,
  owner      uuid,
  created_at timestamptz default now()
);
alter table storage.objects enable row level security;
grant all on storage.objects to authenticated, service_role;
grant select on storage.buckets to anon, authenticated, service_role;
create function storage.foldername(name text) returns text[] language sql immutable as $$
  select (string_to_array(name, '/'))[1:array_length(string_to_array(name, '/'), 1) - 1]
$$;
grant execute on function storage.foldername(text) to anon, authenticated, service_role;
