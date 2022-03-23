from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# for the scratchpad group
from libqtile.config import ScratchPad, DropDown

mod = "mod4" # super/meta/windows/cmd key

my_colors = {
        'bg':        '#282828',
        'd_red':     '#cc241d',
        'd_green':   '#98971a',
        'd_yellow':  '#d79921',
        'd_blue':    '#458588',
        'd_purple':  '#b16286',
        'd_aqua':    '#689d6a',
        'd_orange':  '#d65d0e',

        # Bright colors
        'fg':      '#ebdbb2',
        'red':     '#fb4934',
        'green':   '#b8bb26',
        'yellow':  '#fabd2f',
        'blue':    '#83a598',
        'purple':  '#d3869b',
        'aqua':    '#8ec07c',
        'orange':  '#fe8019',

        'bg0_h':'#1d2021',

        'bg0':  '#282828',
        'bg1':  '#3c3836',
        'bg2':  '#504945',
        'bg3':  '#665c54',
        'bg4':  '#7c6f64',
        'gray': '#928374',

        'bg0_s':'#32302f',
        'fg4':  '#a89984',
        'fg3':  '#bdae93',
        'fg2':  '#d5c4a1',
        'fg1':  '#ebdbb2',
        'fg0':  '#fbf1c7',
}

my_terminal = "alacritty"
my_browser = "firefox"
my_filemanager = "thunar" 
layout_margin=5 # half of the width of the gaps between windows

theme_bg        = my_colors['bg0_h']
theme_fg        = my_colors['fg']
theme_accent    = my_colors['d_yellow']
theme_accent_d  = my_colors['d_yellow']
theme_accent2   = my_colors['blue']
theme_accent3   = my_colors['purple']
theme_disabled  = my_colors['bg3']

#my_wallpaper = '~/.config/qtile/wallpapers/1574318562640.jpg'
my_wallpaper = '.local/share/wallpapers/gruvbox/forest-2.jpg'
my_wallpaper_mode= 'fill'

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Switch focus between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    # Switch focus between monitors
    Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "control"], 'm', lazy.layout.maximize(), desc="Maximize pane"),

    # Move windows between left/right columns or move up/down in current stack.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Swap stack to left/right
    Key([mod, "shift", "control"], "Left", lazy.layout.swap_column_left()),
    Key([mod, "shift", "control"], "Right", lazy.layout.swap_column_right()),
    # Toggle between split and unsplit stack.
    Key([mod, "shift"], "space", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Toggle floating
    Key([mod, "control"], "Return", lazy.window.toggle_floating(), desc="toggle Floating"),
    # Toggle fullscreen
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fulscreen"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Window Management actions
    Key([mod, "control"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift", "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Application shortcuts
    Key([mod], "r", lazy.spawn("rofi -show run"), desc="Spawn a command using Rofi"),
    Key([mod], "t", lazy.spawn(my_terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(my_browser), desc="Launch browser"),
    Key([mod], "f", lazy.spawn(my_filemanager), desc="Launch filemanager"),



    # KeyChord([mod], "z", [
    #     Key([], "x", lazy.spawn("alacritty"))
    # ])

    ### Treetab controls
    # Key([mod, "shift"], "h",
    #     lazy.layout.move_left(),
    #     desc='Move up a section in treetab'
    #     ),
    # Key([mod, "shift"], "l",
    #     lazy.layout.move_right(),
    #     desc='Move down a section in treetthemix-full-gitab'
    #     ),
    # Key([mod, "shift"], "k",
    #    lazy.layout.move_up(),
    #    desc='Move up a section in treetab'
    #    ),
    # Key([mod, "shift"], "j",
    #    lazy.layout.move_down(),
    #    desc='Move down a section in treetab'
    #    ),
    # Key([mod, "control"], "space",
    #     lazy.layout.hide(),
    #     desc='Move down a section in treetab'
    #     ),
    Key([mod, 'shift'], 'd', lazy.group['scratchpad'].dropdown_toggle('term')),
]

# groups = [Group(i) for i in "123456"]
groups = [
    ScratchPad(
        "scratchpad",
        [
            # define a drop down terminal.
            # it is placed in the upper third of screen by default.
            # DropDown("term", "urxvt", opacity=0.8),

            # define another terminal exclusively for ``qtile shell` at different position
            DropDown(
                "term",
                my_terminal,
                x=0.2,
                y=0.04,
                # y = 0, x = 0.5,
                width=0.6,
                height=0.9,
                opacity=0.9,
                # on_focus_lost_hide=True
            )
        ]
    ),
    Group("1", label = '一', layout='columns'),
    Group("2", label = '二', layout='customvertical'),
    Group("3", label = '三', layout='columns'),
    Group("4", label = '四', layout='columns'),
    Group("5", label = '五', layout='columns'),
    Group("6", label = '六', layout='columns'),
    Group("7", label = '七', layout='columns'),
    Group("8", label = '八', layout='columns'),
    Group("9", label = '九', layout='columns'),
    Group("0", label = '十', layout='columns'),


]
# from libqtile.dgroups import simple_key_binder
# dgroups_key_binder = simple_key_binder("mod4")

# bind group keys except the scratchpad group
for i in groups:
    if i.name != 'scratchpad':
        keys.extend([
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name)),

            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False),
                 desc="Switch to & move focused window to group {}".format(i.name)),
        ])

layouts = [
        # DT's treetab:
    # layout.TreeTab(
    #      font = "JetBrains Mono",
    #      fontsize = 14,
    #      sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
    #      section_fontsize = 10,
    #      border_width = 2,
    #      bg_color = "1c1f24",
    #      active_bg = "c678dd",
    #      active_fg = "000000",
    #      inactive_bg = "a9a1e1",
    #      inactive_fg = "1c1f24",
    #      padding_left = 0,
    #      padding_x = 10,
    #      padding_y = 5,
    #      section_top = 10,
    #      section_bottom = 20,
    #      level_shift = 8,
    #      vspace = 3,
    #      panel_width = 200,
    #      place_right = False,
    # ),
    layout.Columns(
        border_normal=theme_bg,
        border_focus=theme_accent,
        border_focus_stack=theme_accent3,
        border_normal_stack=theme_bg,
        border_width=2,
        border_on_single=True,
        margin=layout_margin
    ),
    layout.Columns(
        name = 'customvertical',
        num_columns = 1,
        border_normal=theme_bg,
        border_focus=theme_accent,
        border_focus_stack=theme_accent3,
        border_normal_stack=theme_bg,
        border_width=2,
        border_on_single=True,
        margin=0,
    ),
    layout.Max(),
]

widget_defaults = dict(
    font='JetBrains Mono',
    fontsize=16,
    #background=theme_bg,
    background=theme_bg,
    foreground=theme_fg
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayoutIcon(),
                widget.GroupBox(
                    fontsize         = 20,
                    highlight_method = 'line',
                    rounded          = False,
                    disable_drag     = True,
                    hide_unused      = False,

                    block_highlight_text_color=theme_accent,
                    active=theme_fg,
                    inactive = theme_disabled,
                    highlight_color = [theme_bg, theme_bg],

                    this_current_screen_border=theme_accent,
                    other_screen_border=theme_disabled,

                    this_screen_border=theme_accent,
                    other_current_screen_border=theme_disabled,

                    margin_x=0,
                    padding_x=4
                ),
                widget.Prompt(),
                widget.Chord(),
                # Shows windows in current group:
                widget.TaskList(
                    border=theme_accent_d,
                    highlight_method='block',
                    rounded=False,
                    icon_size=20,
                    borderwidth=0,
                    margin=0,
                    # title_width_method='uniform',
                    txt_floating='🗗 ',
                    txt_maximized='🗖 ',
                    txt_minimized='🗕 ',
                    ),
                widget.Chord(
                   chords_colors={
                       'launch': (theme_accent2, theme_accent3),
                   },
                   name_transform=lambda name: name.upper(),
                ),
                widget.Systray(icon_size= 24),
                widget.Clock(format='%Y/%m/%d', foreground=theme_accent),
                widget.Clock(format='%a'),
                widget.Clock(format='%H:%M', foreground=theme_accent),
            ],
            28,
            margin=[0,0,layout_margin,0],
            opacity=0.85
        ),
        right=bar.Gap(layout_margin),
        bottom=bar.Gap(layout_margin),
        left=bar.Gap(layout_margin),
        wallpaper=my_wallpaper,
        wallpaper_mode=my_wallpaper_mode
    ),
    Screen(
        # top=bar.Gap(layout_margin),
        # right=bar.Gap(layout_margin),
        # bottom=bar.Gap(layout_margin),
        # left=bar.Gap(layout_margin),
        wallpaper=my_wallpaper,
        wallpaper_mode=my_wallpaper_mode
    )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ],
    #border_focus=theme_accent,
    border_focus=theme_accent,
    border_normal=theme_bg,
    border_width=2,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
# wmname = "LG3D"
wmname = "Qtile"
