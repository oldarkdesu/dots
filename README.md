# DOTS

These are my [dotfiles](https://wiki.archlinux.org/title/Dotfiles) which are supposed to be deployed using [GNU Stow](https://www.gnu.org/software/stow/).
In a nutshell, each folder in the root of your _stow directory_ (the folder from which you run the `stow` commands) is a _stow package_ which contains a directory structure relative to the _target directory_ (which by default is the parent directory of the _stow directory_ (which usually is the user's HOME directory)). GNU Stow creates symbolic links to the files inside the _stow package_ following its structure relative to the _target directory_. 
For a more in-depth explanation read the GNU Stow [manual](https://www.gnu.org/software/stow/manual/stow.html). 

## Notes:

- The first thing that zsh does is look at the contents of `/etc/zsh/zshenv`. It is supposed to contain environment variables that are set for all users. This config assumes that you have set the ZDOTDIR environment variable to `$HOME/.config/zsh`.
