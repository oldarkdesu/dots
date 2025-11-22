# DOTS

This is my repository for my personal configuration files, or [dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments), that I use on all of my machines. They're supposed to be managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

The first thing I do when setting up a new system is to **install stow** and clone this repo to `~/dots`

```sh
# I know there are packages for arch, debian and fedora, all called `stow`
sudo pacman -S stow --needed --noconfirm

# Clone the repo to ~/dots
git clone https://github.com/oldarkdesu/dots.git ~/dots

# I also make sure to move/rename default files that may collide with the ones
# in this repo
mv ~/.bashrc ~/.bashrc.old ; mv ~/.bash_profile ~/.bash_profile.old
```

If for some reason someone other than me is reading this, beware that the default _stow dir_ is your current working directory from where you're calling `sotw`, and the _target dir_ is its parent. If you (for some reason) want to clone this repository, and, have it anywhere other than `~/dots/`, make sure to configure stow accordingly, either with an alias like `alias stow='stow -d . -t ~'` or modifying the `.stowrc` file (read the manpage for more info). 

## Usage

This repo contains a set of directories or _packages_ (as `stow` calls them), each directory inside `pkgs` is a stow _package_, a set of files related to particular piece of software; e.g. `pkgs/alacritty/` contains files like `alacritty.toml` or `theme.toml`, but they're under the same directory structure as if they're were in the `$HOME` directory. For a more in-depth explaination of how stow works, read the _man_ page or _info_ page, or you can also [read it online](https://www.gnu.org/software/stow/manual/) through your web browser. 

To "deploy" a _package_, you run the command `stow <package> [<...more packages>]`. I always make sure my CWD is this repo, since here's where I have my .stowrc file with the options I use. 

```sh
cd ~/dots

# Put the bash configuration in its place: 
stow bash alacritty ghostty # you can specify multiple packages

# Unstow the packages from the target dir
stow -D alacritty # or unstow, if you have an alias like `alias unstow='stow -D'

# Stow everything into the target dir
sotw $(echo pkgs/*)  # the shell will expand this to all the directories in the
                     # pkgs/ dir. 
```

## Notes

- The `scripts/.local/bin/scripts/` folder should contain scripts that i can run on any of the linux distros I have installed. Subfolders within it (e.g. `pkgs/scripts/.local/bin/scripts/arch/`) contain distro specific scripts, `pman` for example, which is a small `pacman` wrapper and thus there's no reason to make it available in the PATH on every single distro. The code for detecting the distro and adding the scripts to PATH is located in each shell's profile configuration (currently just `.bash_profile`).
- The `.misc/explicitly-installed-arch-packages.toml` file contains pacages for arch linux that i've installed on my system.
- If you think something in this repository can improve, or have any questions, you can open a [Github Issue](https://github.com/oldarkdesu/dots/issues/new/choose), or send me an email at `oldarkdesu@gmail.com`, or DM me on Discord (`@oldarkdesu`). I'll try to respond as I can `:-)`

## License

This repository is licensed under the [GNU General Public License, version 2 (GPLv2)](LICENSE).

You are free to use, modify, and distribute it under the terms of the GPLv2.
See the LICENSE file for the full license text.

## Third-Party Code

This project includes third-party code via a git submodule. Please be aware that this code is governed by its own license.

* **alacritty-theme**: Located in the `alacritty/.config/alacritty/alacritty-theme` directory, this code is licensed under the [Apache License, Version 2.0](alacritty/.config/alacritty/alacritty-theme/LICENSE). For the full license text, please see the `LICENSE` file within that directory.

