#!/bin/bash

cd /opt/green-commit-bot || exit 1

DATE=$(date '+%Y-%m-%d %H:%M:%S')
FUNC_NAME="AutoGen_$RANDOM"

# Fungsi auto-gen baru
FUNC_BODY="
// Updated at $DATE
func $FUNC_NAME() string {
    return \"Commit at $DATE\"
}
"

# Pastikan main.go ada placeholder untuk fungsi auto-gen:
// #AUTO-GEN-FUNCTIONS# dan // #END-AUTO-GEN-FUNCTIONS#

# Ganti blok fungsi auto-gen di main.go dengan yang baru
sed -i.bak "/\/\/ #AUTO-GEN-FUNCTIONS#/,/\/\/ #END-AUTO-GEN-FUNCTIONS#/c\\
\/\/ #AUTO-GEN-FUNCTIONS#${FUNC_BODY}// #END-AUTO-GEN-FUNCTIONS#" main.go

git add main.go
git commit -m "chore: auto update function at $DATE"
git push origin master
