#!/bin/bash
pgrep --echo -f "/usr/bin/goimapnotify -conf $HOME/.config/imapnotify/trabalho.yaml" || nohup /usr/bin/goimapnotify -conf ~/.config/imapnotify/trabalho.yaml &
sleep 1
/usr/bin/neomutt -F ~/.config/mutt/muttrc-trabalho
