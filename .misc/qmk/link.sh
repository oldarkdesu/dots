#!/bin/sh

working_dir=$(pwd -P)

ln -sf "$working_dir/keyboards/ab" "$HOME/qmk_firmware/keyboards/handwired/"
ln -sf "$working_dir/keymaps/desu" "$HOME/qmk_firmware/keyboards/handwired/dactyl_manuform/5x6/keymaps/"
ln -sf "$working_dir/keyboards/orthodox" "$HOME/qmk_firmware/keyboards/handwired/"
ln -sf "$working_dir/kbflash" "$HOME/.local/bin/"
