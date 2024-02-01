#!/bin/bash

previous_logins_file="/home/leediay/previous_logins.txt"
logged_users_file="/home/leediay/loggedUsers.txt"

# Kiem tra va tao file luu trang thai
if [ ! -e "$previous_logins_file" ]; then
    touch "$previous_logins_file"
fi

if [ ! -e "$logged_users_file" ]; then
    touch "$logged_users_file"
fi

# Danh sach phien dang nhap hien tai
current_logins=$(who | grep "pts\|tty" | awk '{print $1}')


# Danh sach phien dang nhap truoc
previous_logins=$(cat "$previous_logins_file")

# So sanh va lay phien dang nhap moi
new_logins=$(comm -23 <(echo "$current_logins" | sort) <(echo "$previous_logins" | sort))

# Gui mail neu co phien dang nhap moi
if [ -n "$new_logins" ]; then
    email_body="User $new_logins dang nhap thanh cong vao thoi gian $(date +"%T %d/%m/%Y")"
    echo "$email_body" | mail -s "SSH Login" root@localhost
    echo "$email_body" >> "$logged_users_file"
fi

# Ghi lai trang thai cho lan sau
echo "$current_logins" > "$previous_logins_file"
