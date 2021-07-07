#!/bin/bash

date=`date +"%Y-%m-%d"`

sudo mkdir --mode=go+rwx -p $1

if [ ! -e $2 ]
then
    echo "ce dossier n'existe pas, recommencez"
else
    echo "archivage ..."
    chemin=${2%/}
    let "str_slash=`echo $chemin | grep -o "/" | wc -l`"
    if [ $str_slash -ne 0 ]
    then
        dir_name=`echo $chemin | cut -d / --complement -f-$str_slash`
        actif_dir=`pwd`
        if [ ! `echo $chemin | cut -c 1` = '/' ]
        then
            cd $chemin/..
            sudo tar --ignore-failed-read --mode=go+rwx -zcf "$actif_dir/$1$date.tar.gz" "$dir_name"
            sudo chmod go+rwx "$actif_dir/$1$date.tar.gz"
        else
            cd $chemin/..
            sudo tar --mode=go+rwx -zcf "$actif_dir/$1$date.tar.gz" "$2"
            sudo chmod go+rwx "$actif_dir/$1$date.tar.gz"
        fi
    else
        sudo tar --mode=go+rwx -zcf "$1$date.tar.gz" "$2"
        sudo chmod go+rwx "$1$date.tar.gz"
    fi
    echo 'archivage terminé!'
fi
