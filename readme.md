# RBW Menu

This script allows for interactively getting credentials from [rbw](https://github.com/doy/rbw), probably triggered via window-manager keybinding.

## Roadmap

This does exactly what I need; I don't plan to change much.

## Dependencies

- [rbw](https://github.com/doy/rbw)
- [jq](https://github.com/stedolan/jq) - JSON parser
- [wofi](https://hg.sr.ht/~scoopta/wofi) - Optional menu GUI. Trivial to replace with dmenu, bemenu, fzf, or whatever else.

## Installation

For all methods:

0. Look over the source code.
1. Install and set up `rbw`

### From Source

1. Install dependencies
2. clone this repo
3. `# make install`

### Packages

- [AUR](https://aur.archlinux.org/packages/rbw-menu)

(If you package it somewhere else, feel free to submit a PR adding it to this list.)

## Usage

- Show menu, print username for selected item to stdout: `$ rbw-menu`
- Show menu, copy password for selected item to clipboard: `$ rbw-menu password | wl-copy`
- Show menu, copy OTP for selected item to clipboard: `$ rbw-menu code | wl-copy`
- Use a different picker: `RBW_MENU_COMMAND="fzf" rbw-menu`

I use these scripts with sway, though they'll work with anything. Relevant part of my config:

```
bindsym $mod+p exec rbw-menu password | wl-copy
bindsym $mod+u exec rbw-menu username | wl-copy
bindsym $mod+o exec rbw-menu code | wl-copy
```

## Using a different menu

By default, we use wofi. To change this, set the `RBW_MENU_COMMAND` environment variable to anything which can accept a list from STDIN, and return a single line from that list to STDOUT.
