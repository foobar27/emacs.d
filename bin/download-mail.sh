#!/bin/bash

MPOPRC=~/.emacs.d/private/.mpoprc

function setup_password() {
    local KWALLET_FOLDER=$1
    local KWALLET_ENTRY=$2
    local PASSWORD=`kwalletcli -f $KWALLET_FOLDER -e $KWALLET_ENTRY`
    if [[ -z $PASSWORD  ]]; then
	read -s -p "Enter E-Mail password for '$KWALLET_FOLDER/$KWALLET_ENTRY': " PASSWORD
	echo "Trying to put password into kwallet"
	echo $PASSWORD | kwalletcli -f $KWALLET_FOLDER -e $KWALLET_ENTRY -P
    fi
}

source ~/.emacs.d/private/mail-passwords.sh

chmod 600 $MPOPRC

while [ false ] ; do
  echo "retrieving..."
  mpop -a -C $MPOPRC
  sleep 300
done
