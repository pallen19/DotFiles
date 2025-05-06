local wezterm = require 'wezterm'
local module = {}

--[[ function apply_to_config(config)
local homeDirectory = os.getenv("HOME")
  -- Key bindings to manage windows and panes similar to tmux and sesh
  config.keys = {
    -- Split pane horizontally
    { key = '-', mods = 'CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    -- Split pane vertically
    { key = 'v', mods = 'CTRL', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Close current pane
    { key = 'x', mods = 'CTRL', action = wezterm.action.CloseCurrentPane { confirm = true } },
    -- Move to the next pane
    { key = 'l', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Next' },
    -- Move to the previous pane
    { key = 'h', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Prev' },
    -- Create a new window
    { key = 'n', mods = 'CTRL', action = wezterm.action.SpawnWindow },
    -- Close current tab
    { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
    -- Reload configuration
    { key = 'r', mods = 'CTRL', action = wezterm.action.ReloadConfiguration },

    -- Key bindings to open specific project directories in mux sessions
    { key = 'C', mods = 'CTRL | SHIFT', action = wezterm.action_callback(function(win, pane)
        wezterm.mux.spawn_window {
          cwd = homeDirectory .. '/Logistics/Repos/CAL.CD.SingleSpa.Admin.RootConfig.Web'
        }
      end)
    },
    { key = 'U', mods = 'CTRL | SHIFT', action = wezterm.action_callback(function(win, pane)
        wezterm.mux.spawn_window {
          cwd = homeDirectory .. '/Logistics/Repos/CAL.CD.BackOfficeTools.Permissions',
        }
      end)
    },
    { key = 'P', mods = 'CTRL | SHIFT', action = wezterm.action_callback(function(win, pane)
        wezterm.mux.spawn_window {
          cwd = homeDirectory .. '/Logistics/Repos/CAL.CD.PermissionsService',
        }
      end)
    },
 { key = 's', mods = 'CTRL', action = wezterm.action_callback(function(win, pane)
        wezterm.mux.spawn_window {
          cwd = homeDirectory .. '/Logistics/Repos/CAL.CD.BackOfficeTools.Permissions',
        }
      end)
    }, 
  }

end ]]
return module
