## Unlock Plasma session

Situations where I've needed to run these commands: 

- The plasma lockscreen shits itself and is unable to recover, so there's literally a giant text on the screen telling me to manually unlock it
- The plasma lockscreen seems to ignore all keyboard input. 
- There was another time I couldn't log in but I forgot why :P


To unlock a plasma session, use Ctrl+Alt+F3 to get into a TTY. Next, log in and follow these steps:

```bashsh
loginctl list-sessions
# systemd will show a list of sessions, check the SESSION_ID that corresponds
loginctl unlock-session <SESSION_ID>
# The session should now be unlocked. 
```