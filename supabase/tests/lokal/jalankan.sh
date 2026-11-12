#!/usr/bin/env bash
# Menjalankan semua migrasi + uji akses di PostgreSQL lokal sementara.
# Pemakaian: bash supabase/tests/lokal/jalankan.sh
set -euo pipefail
DIR="$(cd "$(dirname "$0")/../.." && pwd)"
PGBIN=/usr/lib/postgresql/16/bin
DATA="$(mktemp -d)"
PORT=54329
if [ "$(id -u)" = "0" ]; then RUN="runuser -u postgres --"; chown postgres "$DATA"; else RUN=""; fi
trap '$RUN $PGBIN/pg_ctl -D "$DATA" stop -m fast >/dev/null 2>&1 || true; rm -rf "$DATA"' EXIT
$RUN $PGBIN/initdb -D "$DATA" -U postgres -A trust >/dev/null
$RUN $PGBIN/pg_ctl -D "$DATA" -o "-p $PORT -k /tmp" -l "$DATA/log" start >/dev/null
sleep 1

PSQL="psql -h /tmp -p $PORT -U postgres -d postgres -v ON_ERROR_STOP=1 -q"
$PSQL -f "$DIR/tests/lokal/supabase_tiruan.sql"
for f in "$DIR"/migrations/*.sql; do
  echo ">> $(basename "$f")"
  $PSQL -f "$f"
done
echo ">> data wilayah"
for f in "$DIR"/data/wilayah_*.sql; do $PSQL -f "$f"; done
$PSQL -c "select tingkat, count(*) from public.wilayah group by 1 order by 1"
echo ">> uji_akses.sql"
$PSQL -P pager=off -f "$DIR/tests/uji_akses.sql"
