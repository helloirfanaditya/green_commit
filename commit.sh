#!/bin/bash

DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Update file dengan isi baru (biar deteksi perubahan)
echo "// Update at $DATE" >> main.go

git add .
git commit -m "chore: auto update at $DATE"
git push origin main
