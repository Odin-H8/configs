local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_wayland = false

config.max_fps = 165

config.leader = {
    key = 'g',
    mods = 'CTRL',
    timeout_milliseconds = 1000,
}

config.keys = {
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab 'DefaultDomain',
    },
    {
        key = 'x',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
        -- Switch to the previous tab with ALT + h
    {
      key = 'h',
      mods = 'ALT',
      action = wezterm.action.ActivateTabRelative(-1),
    },

    -- Switch to the next tab with ALT + l
    {
      key = 'l',
      mods = 'ALT',
      action = wezterm.action.ActivateTabRelative(1),
    },
}

config.default_prog = { 'bash', '-i' }

local toggle_terminal = wezterm.plugin.require("https://github.com/zsh-sage/toggle_terminal.wez")
toggle_terminal.apply_to_config(config, {
    key = "f",
    mods = "ALT",
    direction = "Up",
    size = { Percent = 40 },
    change_invoker_id_everytime = false,
    zoom = {
        auto_zoom_toggle_terminal = false, -- Automatically zoom toggle terminal pane
        auto_zoom_invoker_pane = true, -- Automatically zoom invoker pane
        remember_zoomed = true, -- Automatically re-zoom the toggle pane if it was zoomed before switching away
    }
})

config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true -- Optional to hide the tab bar for a cleaner look

  -- Optional: Set the floating window size and position
config.initial_cols = 120
config.initial_rows = 40

return config
