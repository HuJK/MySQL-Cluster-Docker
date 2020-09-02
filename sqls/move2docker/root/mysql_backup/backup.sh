#!/bin/bash
cd /root/mysql_backup
s7z="7za"
set -x
mkdir -p backups
ct=$(date +%s)
if [ $1 == "all" ]; then
    rm -rf *_new
    mkdir -p backups_new
    mkdir -p backups_7z_new
    cd backups_new
    ct="${ct}_raw"
    $s7z -mx=1 a ../backups_7z_new/${ct}.7z /var/lib/mysql /var/lib/mysql-files /var/lib/mysql-keyring
    rclone copy ../backups_7z_new/${ct}.7z gdrive:archived 
    rm ../backups_7z_new/${ct}.7z
    ct=$(date +%s)
    ct="${ct}_all"
    mkdir $ct
    set -x
    xtrabackup --backup --target-dir=$ct
    set +x
    $s7z -mx=1 a ../backups_7z_new/${ct}.7z $ct
    cd ..
    rm -rf backups
    rm -rf backups_7z
    mv backups_new backups
    mv backups_7z_new backups_7z
    rclone sync /root/mysql_backup/backups_7z/ gdrive:backups --backup-dir=gdrive:archived
else
    cd backups
    max=-1
    max_fn=-1
    for file in *
    do
        num=${file%_*}
        if [[ $num -gt $max ]];then
            max=$num
            max_fn=$file
        fi
    done
    if [ $max == "-1" ]; then
        echo "no previous backup found, can't do increment backup"
        exit -1
    else
        echo "previous backup found: $max_fn"
        ct="${ct}_inc"
        mkdir $ct
        xtrabackup --backup --target-dir=$ct --incremental-basedir=$max_fn
        $s7z a ../backups_7z/${ct}.7z $ct
        rclone sync /root/mysql_backup/backups_7z/ gdrive:backups --backup-dir=gdrive:archived
    fi
fi
