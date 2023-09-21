# RBW Menu

This script allows for interactively getting credentials from [rbw](https://github.com/doy/rbw), probably triggered via window-manager keybinding.

- **`rbw-menu`**: wofi powered menu for picking credentials.
- `gen-otp`: reads a TOTP credential from STDIN in URI format and returns a code. (I'm surprised this doesn't exist already, but I couldn't find it.)

They're designed for my own particular use case, but I think they're general enough to share.

## Dependencies

- [rbw](https://github.com/doy/rbw)
- [jq](https://github.com/stedolan/jq) - JSON parser
- [wofi](https://hg.sr.ht/~scoopta/wofi) - Optional menu GUI. Trivial to replace with dmenu, bemenu, fzf, or whatever else.
- [trurl](https://github.com/curl/trurl) - Optional, required for TOTP codes.
- [oathtool](https://www.nongnu.org/oath-toolkit/) - Optional, required for TOTP codes.

## Installation From Source

0. Look over the source code.
1. Install dependencies
2. Configure `rbw`
3. clone this repo, `sudo make install`

## Usage

- Show menu, print username for selected item to stdout: `$ rbw-menu`
- Show menu, copy password for selected item to clipboard: `$ rbw-menu password | wl-copy`
- Show menu, copy OTP for selected item to clipboard: `$ rbw-menu totp | gen-otp | wl-copy`
- Use a different picker: `RBW_MENU_COMMAND="fzf" rbw-menu`

I use these scripts with sway, though they'll work with anything. Relevant part of my config:

```
bindsym $mod+p exec rbw-menu password | wl-copy
bindsym $mod+u exec rbw-menu username | wl-copy
bindsym $mod+o exec rbw-menu totp | gen-otp | wl-copy
```

## Using a different menu

By default, we use wofi. To change this, set the `RBW_MENU_COMMAND` environment variable to anything which can accept a list from STDIN, and return a single line from that list to STDOUT.
