--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)
local selectionRule = hl.layer_rule({
	name = "no-anim-for-selection",
	match = { namespace = "selection" },
	no_anim = true,
})

-- Window Rules
-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({ match = { class = "^(kitty)$" }, workspace = 1 })
hl.window_rule({
	match = { class = "^(google-chrome|brave-browser|LibreWolf|firefox|app.zen_browser.zen|helium)$" },
	workspace = 2,
})
hl.window_rule({ match = { class = "^(Emacs|codium|jetbrains-pycharm)$" }, workspace = 4 })
hl.window_rule({ match = { class = "^(vlc)$" }, workspace = 5 })

hl.window_rule({
	name = "Neomutt",
	match = { class = "^(kitty)$", title = "^Neomutt-(Pessoal|Trabalho|Faculdade)$" },
	workspace = 3,
})

hl.window_rule({
	name = "ncspot",
	match = { class = "^(kitty)$", title = "^(ncspot)$" },
	workspace = 5,
})