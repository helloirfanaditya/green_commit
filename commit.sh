#!/bin/bash

cd /opt/green-commit-bot || exit 1

DATE=$(date '+%Y-%m-%d %H:%M:%S')
FUNC_NAME="AutoGen_$RANDOM"

# Fungsi auto-gen baru (string multiline)
read -r -d '' FUNC_BODY << EOM
// #AUTO-GEN-FUNCTIONS//
// Updated at $DATE
func $FUNC_NAME() string {
    return "Commit at $DATE"
}
// #END-AUTO-GEN-FUNCTIONS//
EOM

# Buat file temp baru dengan isi main.go yang fungsi auto-gen-nya sudah diganti
sed "/\/\/ #AUTO-GEN-FUNCTIONS#/,/\/\/ #END-AUTO-GEN-FUNCTIONS#/c\\
$FUNC_BODY" main.go > main.go.tmp && mv main.go.tmp main.go

git add main.go
git commit -m "chore: auto update function at $DATE"
git push origin master
