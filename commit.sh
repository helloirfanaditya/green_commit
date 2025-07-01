#!/bin/bash

DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "// Update at $DATE" >> main.go

git add .
git commit -m "chore: auto update at $DATE"
git push origin master
