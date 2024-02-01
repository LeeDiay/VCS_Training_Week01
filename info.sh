#!/bin/bash

echo "          [THONG TIN HE THONG]"
echo "Ten may: `whoami`"
echo "Ban phan phoi: `cat /etc/os-release | grep -w "VERSION"|cut -d '=' -f 2 `"
echo "Phien ban dieu hanh: `cat /etc/os-release | grep -w "VERSION_ID" |cut -d '=' -f 2 `"
echo "Ten CPU: `cat /proc/cpuinfo | grep -w "model name" | uniq | cut -d ':' -f 2 `"
echo "Thong tin CPU: `lscpu| grep -w "Architecture" | cut -d ':' -f 2 ` "
echo "Toc do CPU `lscpu | grep -w "CPU MHz" | cut -d ':' -f 2` Mhz"
echo "`free -h  | grep "G" | uniq | cut -d 'G' -f 1 ` Gb" 
echo "Dia chi ip: `ip addr |grep -w "192"|cut -d '/' -f 2 | tr -s ' '| cut -d ' ' -f 3 `"
users="Danh sach user: `cut -d : -f 1 /etc/passwd | sort`"
echo $users | sed 's/ /\n/4g'
echo "Danh sach tien trinh dang chay duoi quyen root: \n\n\n"
ps -fU root |sort
echo  "Danh sach cac port dang mo: \n\n\n"
netstat | sort -n
echo  "Danh sach file ma other co quyen ghi: \n\n\n"
find -perm -o=r
echo -e "Danh sach cac phan mem duoc cai dat tren he thong: \n"
apt list --installed