# DOTS

This is my repository for my personal config files. They're supposed to be managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Usage

**NOTICE:** The way I have this set up, the root of the repo should be the _stow dir_, and your `$HOME` should be the stow's _target dir_. Since I clone my repos under `~/repos/`, my _stow dir_ should point to `~/repos/dots` and my _target dir_ sould be `~`.  
Whenever I clone this repo to a new machine I make sure to first **install stow** and then run the following command:

```sh
# if anyone is reading this, make sure to customize this as needed
echo -e "--dir ~/repos/dots --target ~" | tee --append $HOME/{,repos/dots/}.stowrc
```

Additionally, by default your current dir and its direct parent are considered the _stow dir_ and _target dir_ respectively, so if I simply clone this repo to `~/dots` and I run every command from this directory, the command above becomes irrelevant, since my stow dir will be the the root of the repo, which is directly under the home directory.  

This repo contains a set of directories or _packages_ (as `stow` calls them), each directory here is a stow _package_, a set of files related to particular piece of software; e.g. `packages/alacritty/` contains files like `alacritty.toml` or `theme.toml`, but they're under the same directory structure as if they're were in the `$HOME` directory. For a more in-depth explaination of how stow works, read the _man_ page or _info_ page, or you can also [read it online](https://www.gnu.org/software/stow/manual/) through your web browser. 

To "deploy" a _package_, you run the command `stow <package> [<...more packages>]` stow expects every _package_ to be a directory, so if you want to deploy everything at once you have to do `stow */` (notice the forward slash at the end!), since this repo contains other files like `LICENCE` or `README.md`. 
