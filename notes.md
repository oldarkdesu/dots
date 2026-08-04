## Software

Software that should be installed in order to get things working right (aside from the very programs that we're configuring, like alacritty, bash, etc.).

### Software that kinda should be installed

(assume the following are the package names for the official arch repos. Otherwise it will be noted)

- `prettier` for formatting stuff in zed. I actually use the NPM version (which I get using PNPM)
- `sxhkd` & `lemonbar` they do not come with the bsmwm package i think
- `ly`. I dont really configure it so there's no files about it in here but it's useful for getting a greeter fully in the tty
- `zathura-pdf-mupdf` for opening pdf in zathura
- `openssh`

### Software that DEFINITELY should be installed

(assume the following are the package names for the official arch repos. Otherwise it will be noted)

- `git` (duh) 
- `stow` (duh)

## Unlock Plasma session

Situations where I've needed to run these commands: 

- The plasma lockscreen shits itself and is unable to recover, so there's literally a giant text on the screen telling me to manually unlock it
- The plasma lockscreen seems to ignore all keyboard input. 
- There was another time I couldn't log in but I forgot why :P


To unlock a plasma session, use Ctrl+Alt+F3 to get into a TTY. Next, log in and follow these steps:

```sh
loginctl list-sessions
# systemd will show a list of sessions, check the SESSION_ID that corresponds
loginctl unlock-session <SESSION_ID>
# The session should now be unlocked. 
```