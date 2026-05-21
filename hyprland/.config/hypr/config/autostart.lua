-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("$HOME/.config/hypr/portals.sh")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("arch-update --tray")
	hl.exec_cmd("udiskie & swaync & waybar & hypridle & firewall-applet")
	hl.exec_cmd("$HOME/.config/tmux/import_env_vars tmux")
	hl.exec_cmd("sleep 1 && hyprpaper")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Dark'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
end)