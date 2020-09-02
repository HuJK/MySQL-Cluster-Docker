#!/bin/bash
#set -x
#Extract all 7z files to folders
s7z="7za"
set -e
rclone sync gdrive:backups  /root/mysql_backup/backups_7z/
mkdir -p /root/mysql_backup/backups
cd /root/mysql_backup || exit

cd backups_7z || exit
for file in *.7z
do
    if [ ! -d "../backups/${file%.*}" ]; then
        $s7z x $file -o"../backups_temp"
    fi
done

mkdir -p ../backups_temp/
mv ../backups_temp/* ../backups || true
rm -r ../backups_temp/

cd ../backups || exit

for folder in *
do
    FILE=../backups_7z/${folder}.7z
    if ! test -f "$FILE"; then
        echo "${FILE} not exists , removing ${folder}"
        rm -rf $folder
    fi
done


full=-1
full_fn=-1
#find latest all backup
for file in *_all
do
    num=${file%_*}
    if [[ $num -gt $full ]];then
        full=$num
        full_fn=$file
    fi
done

if [ $full == "-1" ]; then
    echo "no previous full backup found, can't recover"
    exit -1
else
    is_modified="0"
    echo "previous full backup found: $full_fn"
    prev_fn=$(cat ../restore_prev)
    if [ $(expr length "${prev_fn}") == "0" ] || [[ ${prev_fn%_*} -lt $full ]]; then
        prev_fn=$full_fn
        prev_num=${full_fn%_*}
        echo "Prepare full record ${full_fn}"
        xtrabackup --prepare --apply-log-only --target-dir=$full_fn
        echo $full_fn > ../restore_prev
        is_modified="1"
    fi
    echo "Applying increment records"
    prev_num=${prev_fn%_*}
    for file in `ls . | grep inc | sort -V`
    do
        num=${file%_*}
        if [[ $num -gt $prev_num ]];then
        echo "Applying increment record: ${file}"
            xtrabackup --prepare --apply-log-only --target-dir=$full_fn --incremental-dir=$file
            echo $file > ../restore_prev
            is_modified="1"
        fi
    done
    if [ $is_modified == "1" ];then
        echo "Copy modified backups back"
        /etc/init.d/mysql stop
        rm -r /var/lib/mysql/* || true
        xtrabackup --copy-back --target-dir=$full_fn
        chown -R mysql:mysql /var/lib/mysql
        /etc/init.d/mysql start
        curl -d "restart backend" http://172.33.1.1:26410
    else
        echo "No new records"
    fi
fi

