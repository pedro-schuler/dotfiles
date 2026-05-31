---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local programs = {
	terminal = "kitty -e tmux new-session -A -s main",
	fileManager = "thunar",
	menu = "fuzzel --terminal=kitty",
	exitMenu = "nwg-bar",
	lock = "pidof hyprlock || hyprlock",
	clipboard = "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy",
	printScreen = 'grim -g "$(slurp -d)"',
	printAndAnnotate = 'grim -g "$(slurp)" - | satty -f - --copy-command wl-copy -o "~/Imagens/%Y%m%d_%Hh%Mm%Ss_satty.png"',
	notifications = "swaync-client -t -sw",
	secrets = "$HOME/.local/bin/user-passmenu",
	browser = "flatpak run app.zen_browser.zen --ozone-platform=wayland --enable-features=UseOzonePlatform",
}

return programs
