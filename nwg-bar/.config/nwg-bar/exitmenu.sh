#!/usr/bin/env bash

if [[ $1 == "--shutdown" ]]; then
  exec hyprshutdown -t 'Desligando...' --post-cmd 'systemctl -i poweroff'
elif [[ $1 == "--reboot" ]]; then
  exec hyprshutdown -t 'Reiniciando...' --post-cmd 'systemctl reboot'
elif [[ $1 == "--logout" ]]; then
  exec hyprshutdown -t 'Deslogando...'
elif [[ $1 == "--lock" ]]; then
  pidof hyprlock || hyprlock
else
  exec hyprshutdown "$@"
fi
