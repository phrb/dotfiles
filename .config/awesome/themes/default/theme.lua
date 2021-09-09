---------------------------
-- Default awesome theme --
---------------------------

theme = {}

-- Disable icons:
theme.tasklist_disable_icon = true

theme.font          = "Helvetica 11"

-- Begin Xresources theme

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- load vector assets' generators for this theme

base00 = "#181818"
base01 = "#282828"
base02 = "#383838"
base03 = "#585858"
base04 = "#b8b8b8"
base05 = "#d8d8d8"
base06 = "#e8e8e8"
base07 = "#f8f8f8"
base08 = "#ab4642"
base09 = "#dc9656"
base0A = "#f7ca88"
base0B = "#a1b56c"
base0C = "#86c1b9"
base0D = "#7cafc2"
base0E = "#ba8baf"
base0F = "#a16946"

color0 = base00
color1 = base08
color2 = base0B
color3 = base0A
color4 = base0D
color5 = base0E
color6 = base0C
color7 = base05
color8 = base03
color9 = base08
color10 = base0B
color11 = base0A
color12 = base0D
color13 = base0E
color14 = base0C
color15 = base07

color16 = "#dc9656"
color17 = "#a16946"
color18 = "#282828"
color19 = "#383838"
color20 = "#b8b8b8"
color22 = "#e8e8e8"

background = base00
foreground = base05

theme.bg_normal     = background
theme.bg_focus      = color18
theme.bg_urgent     = color1
theme.bg_minimize   = color8
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = foreground
theme.fg_focus      = foreground
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = color0
theme.border_focus  = theme.bg_focus
theme.border_marked = color10

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

-- Recolor titlebar icons:
--
local function darker(color_value, darker_n)
    local result = "#"
    for s in color_value:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
        local bg_numeric_value = tonumber("0x"..s) - darker_n
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%2.2x", bg_numeric_value)
    end
    return result
end
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_normal, "normal"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_normal, -60), "normal", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "normal", "press"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_focus, "focus"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_focus, -60), "focus", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "focus", "press"
)

-- Previous Theme commented out:

-- theme.bg_normal     = "#181818"
-- theme.bg_focus      = "#282828"
-- theme.bg_urgent     = "#ff0000"
-- theme.bg_minimize   = "#383838"
-- theme.bg_systray    = theme.bg_normal
--
-- theme.fg_normal     = "#aaaaaa"
-- theme.fg_focus      = "#ffffff"
-- theme.fg_urgent     = "#ffffff"
-- theme.fg_minimize   = "#ffffff"
--
-- theme.border_width  = 0
-- theme.border_normal = "#000000"
-- theme.border_focus  = "#535d6c"
-- theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- End previous theme

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 16
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.wallpaper = "~/cloud/old_dropbox/neuromancer_wallpaper_nogrid_notitle.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
