#!/bin/bash
pgrep --echo -f "/usr/bin/goimapnotify -conf $HOME/.config/imapnotify/faculdade.yaml" || nohup /usr/bin/goimapnotify -conf ~/.config/imapnotify/faculdade.yaml &
sleep 1
/usr/bin/neomutt -F ~/.config/mutt/muttrc-faculdade
