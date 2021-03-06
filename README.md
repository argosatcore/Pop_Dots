<p align="center"><img src="https://user-images.githubusercontent.com/64110504/117901326-54076800-b288-11eb-9735-5ec61bc1b0b1.png" width="275px"></p>
<h1 align="center">Argos's Pop!_Dots Files</h1> 
<p align="center">A collection of my experiences with Linux in the form of dot files.</p><br><br>                                                                                

## Table of Contents

- [Pop Shell](#pop-shell): To me, Pop's most prominent asset; one which has made the Gnome desktop a very versatile Linux DE.
- [Shared Features](#shared-features): Behaviors shared between stacking and auto-tiling modes
- [Stacking Mode](#stacking-mode): Behaviors specific to the stacking mode
- [Auto-Tile Mode](#auto-tile-mode): Behaviors specific to the auto-tiling mode
- [Plugins](#plugins): Details about plugins and development

---

## Pop Shell

Pop Shell is a keyboard-driven layer for GNOME Shell which allows for quick and sensible navigation and management of windows. The core feature of Pop Shell is the addition of advanced tiling window management. 

Tiling window management in GNOME is virtually nonexistent, which makes the desktop awkward to interact with when your needs exceed that of two windows at a given time. Luckily, GNOME Shell is an extensible desktop with the foundations that make it possible to implement a tiling window manager on top of the desktop

![Screenshot from 2021-05-12 14-02-21](https://user-images.githubusercontent.com/64110504/121616004-4bd55080-ca1f-11eb-95b8-28a15bfc759a.png)

---

## Shared Features

Features which are shared between stacking and auto-tiling modes.

### Directional Keys

These are key to many of the shortcuts utilized by tiling window managers. This document will henceforth refer to these keys as `<Direction>`, which default to the following keys:

- `Left` or `h`
- `Down` or `j`
- `Up` or `k`
- `Right` or `l`

### Overridden GNOME Shortcuts

- `Super` + `q`: Close window
- `Super` + `m`: Maximize the focused window
- `Super` + `,`: Minimize the focused window
- `Super` + `Esc`: Lock screen
- `Super` + `f`: Files
- `Super` + `e`: Email
- `Super` + `b`: Web Browser
- `Super` + `t`: Terminal

### Window Management Mode

> This mode is activated with `Super` + `Return`.

Window management mode activates additional keyboard control over the size and location of the currently-focused window. The behavior of this mode changes slightly based on whether you are in auto-tile mode, or in the default stacking mode. In the default mode, an overlay is displayed snapped to a grid, which represents a possible future location and size of your focused window. This behavior changes slightly in auto-tiling mode, where resizes are performed immediately, and overlays are only shown when swapping windows.

Activating this enables the following behaviors:

- `<Direction>`
  - In default mode, this will move the displayed overlay around based on a grid
  - In auto-tile mode, this will resize the window
- `Shift` + `<Direction>`
  - In default mode, this will resize the overlay
  - In auto-tile mode, this will do nothing
- `Ctrl` + `<Direction>`
  - Selects a window in the given direction of the overlay
  - When `Return` is pressed, window positions will be swapped
- `Shift` + `Ctrl` + `<Direction>`
  - In auto-tile mode, this resizes in the opposite direction
- `O`: Toggles between horizontal and vertical tiling in auto-tile mode
- `~`: Toggles between floating and tiling in auto-tile mode
- `Return`: Applies the changes that have been requested
- `Esc`: Cancels any changes that were requested

### Window Focus Switching

When not in window management mode, pressing `Super` + `<Direction>` will shift window focus to a window in the given direction. This is calculated based on the distance between the center of the side of the focused window that the window is being shifted from, and the opposite side of windows surrounding it.

Switching focus to the left will calculate from the center of the east side of the focused window, to the center of the west side of all other windows. The window with the least distance is the window we pick.

### Launcher

The launcher is summoned with `Super` + `/`. The search list displays matching windows based on their window name and title, and applications on the system which can be launched. The arrow keys are used to select an application or window from the search list. If it is a window, the selected window will be visually highlighted with an overlay, in the event that two windows have the same name and title. Pressing `Return` on a window will bring that window to focus, switching to its workspace, and unminimizing it if it was minimized.

#### Launcher Modes

By default, the launcher searches windows and applications. However, you can designate a special launch mode using one of the supported prefixes:

- `:`: Execute a command in `sh`
- `run` | `t:`: Execute a command in `sh` in a terminal
- `=`: Calculator mode, powered by [MathJS](https://mathjs.org/)
- `/` | `~`: Navigate and open directories and files in the file system
- `d:`: Search recent documents

### Inner and Outer Gaps

Gaps improve the aesthetics of tiled windows, and make it easier to grab the edge of a specific window. We've decided to add support for inner and outer gaps, and made these settings configurable in the extension's popup menu.

### Hiding Window Title Bars

Windows with server-side decorations may have their title bars completely hidden, resulting in additional screen real estate for your applications, and a visually cleaner environment. This feature can be toggled in the extension's popup menu. Windows can be moved with the mouse by holding `Super` when clicking and dragging a window to another location. Windows may be closed by pressing GNOME's default `Super` + (`grave` / `~`) shortcut.

---

## Stacking Mode

This is the default mode of Pop Shell, which combines traditional stacking window management, with optional tiling window management features.

### Display Grid

In this mode, displays are split into a grid of columns and rows. When entering tile mode, windows are snapped to this grid as they are placed. The number of rows and columns are configurable in the extension's popup menu in the panel.

### Snap-to-Grid

An optional feature to improve your tiling experience is the ability to snap windows to the grid when using your mouse to move and resize them. This provides the same precision as entering window management mode to position a window with your keyboard, but with the convenience and familiarity of a mouse. This feature can be enabled through the extension's popup menu.

---

## Auto-Tile Mode

This provides the tiling window manager experience, where windows are automatically tiled across the screen as they are created. This feature is disabled by default, but can be enabled through the extension's popup menu in the panel. When enabled, windows that were launched before enabling it will not be associated with any tree. Dragging and dropping them will begin to tile them in a tree.

### Keyboard Shortcuts

- `Super` + `O`
  - Toggles the orientation of a fork's tiling orientation
- `Super` + `G`
  - Toggles a window between floating and tiling. 
  - See [#customizing the window float list](#customizing-the-floating-window-list)

### Feature Overview

- If no windows are on a display, a newly-opened window will start out maximized on the display
- As new windows are opened, they are tiled into the currently-focused window
- Windows can be detached and retached to different areas of the tree by dragging and dropping them
- The default tiling orientation is based on the dimensions of the window being attached to
- The tiling orientation of the fork associated with the focused window can be altered with `Super` + `O`.
- The division of space between branches in a fork can be altered by resizing windows
  - Window resizes can be carried out with the mouse
  - Tiling mode may also be used to adjust sizes with the keyboard
- Ultra-wide displays are treated as two separate displays by default (**Unimplemented**)

### Customizing the Floating Window List
There is file `$XDG_CONFIG_HOME/pop-shell/config.json` where you can add the following structure:
```
{
  class: "<WM_CLASS String from xprop>",
  title: "<Optional Window Title>"
}
```
For example, doing `xprop` on GNOME Settings (or GNOME Control Center), the WM_CLASS values are `gnome-control-center` and `Gnome-control-center`. Use the second value (Gnome-control-center), which pop-shell will read. `title` is optional.

After applying changes in the `config.json`, you can reload the tiling if it doesnt work the first time.

## Plugins

### Launcher Plugins

Pop Shell supports extending the functionality of its launcher, and comes with some plugins by default. System plugins are stored in `/usr/lib/pop-shell/launcher/`, while user plugins are stored in `$HOME/.local/share/pop-shell/launcher/`. Some plugins are included by default:

- [calc](src/plugins/calc)
- [files](src/plugins/files)
- [pulse](src/plugins/pulse)
- [recent](src/plugins/recent)
- [terminal](src/plugins/terminal)
- [web](src/plugins/web)
- [scripts](src/plugin_scripts.ts)

> Plugin developers, see [the API documentation for the launcher API](https://github.com/pop-os/shell/blob/master/src/plugins/README.md).

### Scripts Plugin

This builtin plugin displays scripts in search results. Included with Pop Shell is a set of scripts for log out, reboot, and power off. Scripts are stored in `/usr/lib/pop-shell/scripts/` and `$HOME/.local/share/pop-shell/scripts/`. [See the included scripts as an example of how to create our own](https://github.com/pop-os/shell/tree/master/src/scripts).


