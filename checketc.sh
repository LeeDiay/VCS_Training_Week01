#!/bin/bash

LOG_FILE="/var/log/checketc.log"

# Kiem tra file log da ton tai chua
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Luu lai thoi gian cua lan chay truoc
last_time=$(stat -c %Y "$LOG_FILE")

# Danh sach file
files_before=$(ls -l /etc)

# Kiem tra file dc tao moi
new_files=$(find /etc -type f -newermt "$last_time" 2>/dev/null)

if [ -n "$new_files" ]; then
    echo "=== DANH SACH CAC FILE TAO MOI ===" >> "$LOG_FILE"
    echo "$new_files" | while read -r file; do
        echo "Files: $file" >> "$LOG_FILE"
        if [ -f "$file" ]; then
            head -n 10 "$file" >> "$LOG_FILE"
        fi
    done
fi

# Kiem tra cac file bi sua doi
changed_files=$(find /etc -type f -cnewer "$LOG_FILE" 2>/dev/null)

if [ -n "$changed_files" ]; then
    echo "=== CAC FILE BI SUA DOI ===" >> "$LOG_FILE"
    echo "$changed_files" >> "$LOG_FILE"
fi

# Kiem tra cac file bi xoa
deleted_files=$(comm -23 <(echo "$files_before" | awk '{print $NF}' | sort) <(ls -l /etc | awk '{print $NF}' | sort))

if [ -n "$deleted_files" ]; then
    echo "=== CAC FILE BI XOA ===" >> "$LOG_FILE"
    echo "$deleted_files" >> "$LOG_FILE"
fi

# Ghi log vao file
echo "=== DU LIEU DUOC CAP NHAT VAO $(date) ===" >> "$LOG_FILE"

# Gui mail cho qtv
cat "$LOG_FILE" | mail -s "DU LIEU KIEM TRA" root@localhost
