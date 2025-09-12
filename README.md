# DOTS

This is my repository for my personal config files.

## Locations

- `bash` should be copied to `~/.config/bash`
  - `~/.bashrc` should be symlinked to `~/.config/bash/bashrc`
  - `~/.bash_profile` should be symlinked to `~/.config/bash/bash_profile`
- The contents of `vscode/` should be copied to `~/.config/Code/User/`
- `alacritty` should be copied to `~/.config/alacritty`

## Commands

```sh
\rm -r ~/.config/bash.old && \
 mv ~/.config/bash ~/.config/bash.old && \
 cp -r bash ~/.config/bash
```
