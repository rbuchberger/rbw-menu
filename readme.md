# Bitwarden Wrapper

This is a set of tools to make actually using the Bitwarden CLI to manage your passwords convenient.
There are 4 related bash scripts here:

- `bww`: **B**it**W**arden **W**rapper. Run `bw` commands without managing the session key.
- `bww-setup`: Generates, encrypts, and stores a session key.
- **`bww-menu`**: wofi powered menu for accessing credentials.
- `gen-otp`: reads a TOTP credential from STDIN in URI format and returns a code. (I'm surprised this doesn't exist already, but I couldn't find it.)

They're designed for my own particular use case, but I think they're general enough to share.

## Features

- Simple enough to read yourself, trivial to fork & modify. They're just bash, written as obviously as possible. I don't like complicated code that deals with secrets.
- With the power of caching and some trickery, the menu feels pretty fast even though `bw` commands are slow.
- No configuration required
- Easy guided setup

## Dependencies

- [gnupg] + a working private GPG key. If password protected, a GUI pinentry is also advisable.
- [bitwarden-cli] - Configured, but not necessarily logged in.
- [jq] (JSON parser)
- [wofi] (menu GUI). It's trivial to replace it with dmenu, or bemenu, or whatever else.
- [trurl] - AUR (extract params from oath uri for TOTP generation)
- [oath-toolkit] (generate TOTP)

## Installation From Source

0. Look over the source code.
1. Install dependencies
2. Configure `bw`, if required (For example, if you are using something other than the default server.)
3. clone this repo, `sudo make install`
4. Run `bww-setup`, enter prompted information.
5. Verify it's working: `bww unlock --check`

## Usage

- Run arbitrary `bw` commands: `bww status`
- Show menu, print username for selected item to stdout: `$ bww-menu`
- Show menu, copy password for selected item to clipboard: `$ bww-menu password | wl-copy`
- Show menu, copy OTP for selected item to clipboard: `$ bww-menu totp | gen-otp | wl-copy`
- Use a different picker: `BWW_MENU_COMMAND="fzf" bww-menu`

I use these scripts with sway, though they'll work with anything. Relevant part of my config:

```
bindsym $mod+p exec bww-menu password | wl-copy
bindsym $mod+u exec bww-menu username | wl-copy
bindsym $mod+o exec bww-menu totp | gen-otp | wl-copy
```

## Using a different menu

By default, we use wofi. To change this, set the `BWW_MENU_COMMAND` environment variable to anything which can accept a list from STDIN, and return a single line from that list to STDOUT.

## Caveats

- `bww` will fail with a helpful error if the session key is missing, but not if it is invalid. It's possible to detect this situation automatically, but it adds like a second to every invocation and that's too slow IMO. **If you are prompted by `bww` for your master password, cancel and rerun `bww-setup`**.
- The source list for bww-menu is updated on every invocation. Changes take one call to show up. (For example, if you add an item to your vault, the next time you run bww-menu it won't be there. The time after that it will.)
- A list of all credential names & their ids are cached in your home directory. (Not usernames or passwords, just the displayed names in bitwarden and a unique identifier for them used internally.) If you consider this information to be sensitive, don't use this tool.
- For a short period of time, a temp file is created with the selected item name when using bww-menu. Additionally, the last selected item is cached by wofi.
