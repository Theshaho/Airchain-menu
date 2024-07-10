#!/bin/bash
FILE=/root/res.sh
if test -f "$FILE"; then
    echo "$FILE exists."
elif
   cp $(pwd)/res.sh /root/res.sh
fi

clear

 cat << "EOF"
===============================================================================================
==  __       ___      .___  ___.      _______. __    __       ___       __    __    ______   ==
== |  |     /   \     |   \/   |     /       ||  |  |  |     /   \     |  |  |  |  /  __  \  ==
== |  |    /  ^  \    |  \  /  |    |   (----`|  |__|  |    /  ^  \    |  |__|  | |  |  |  | ==
== |  |   /  /_\  \   |  |\/|  |     \   \    |   __   |   /  /_\  \   |   __   | |  |  |  | ==
== |  |  /  _____  \  |  |  |  | .----)   |   |  |  |  |  /  _____  \  |  |  |  | |  `--'  | ==
== |__| /__/     \__\ |__|  |__| |_______/    |__|  |__| /__/     \__\ |__|  |__|  \______/  ==
==                                                                                           ==
===============================================================================================
             Developed by: @iamshaho
             Twitter: https://twitter.com/iamshaho
             Telegram: https://t.me/ubuntufornodes
=========================================================================
EOF

read -p "1: check logs
2: restart stationd and show logs
3: rollback last 3 pods and show logs
4: exit 
" choice

if [ "$choice" == "1" ]; then
  sudo journalctl -u stationd -f --no-hostname -o cat
elif [ "$choice" == "2" ]; then
  echo "wait please ..."
  sudo systemctl restart stationd && sudo journalctl -u stationd -f --no-hostname -o cat
elif [ "$choice" == "3" ]; then
  echo "wait please ..."
  sudo systemctl stop stationd &&
  cd tracks &&
  git pull &&
  go run cmd/main.go rollback &&
  go run cmd/main.go rollback &&
  go run cmd/main.go rollback &&
  sudo systemctl restart stationd &&
  sudo journalctl -u stationd -f --no-hostname -o cat
elif [ "$choice" == "4" ]; then
  exit
else
  echo "Not a valid choice"
  exit
fi
