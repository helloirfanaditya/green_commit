#!/bin/bash

cd /opt/green-commit-bot || exit 1

DATE=$(date '+%Y-%m-%d %H:%M:%S')
FUNC_NAME="AutoGen_$RANDOM"

# Buat isi blok fungsi auto-gen baru di temp file
cat > new_funcs.go <<EOF
// #AUTO-GEN-FUNCTIONS//
// Updated at $DATE
func $FUNC_NAME() string {
    return "Commit at $DATE"
}
// #END-AUTO-GEN-FUNCTIONS//
EOF

# Hapus blok lama dari main.go dan sisipkan blok baru
awk '
  BEGIN { in_block=0 }
  /\/\/ #AUTO-GEN-FUNCTIONS#/ { print; system("cat new_funcs.go"); in_block=1; next }
  /\/\/ #END-AUTO-GEN-FUNCTIONS#/ { in_block=0; next }
  !in_block { print }
' main.go > main.go.tmp

mv main.go.tmp main.go
rm new_funcs.go

git add main.go
git commit -m "chore: auto update function at $DATE"
git push origin master
