#!/bin/bash
pgrep --echo -f "/usr/bin/goimapnotify -conf $HOME/.config/imapnotify/pessoal.yaml" || nohup /usr/bin/goimapnotify -conf ~/.config/imapnotify/pessoal.yaml &
sleep 1
/usr/bin/neomutt -F ~/.config/mutt/muttrc-pessoal
