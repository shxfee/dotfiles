#!/bin/bash
rm "$HOME/.config/fish"
rm "$HOME/.config/nvim"
rm "$HOME/.config/lazygit"

base="$HOME/dotfiles"

ln -sf ${base}/fish ~/.config/fish
ln -sf ${base}/nvim ~/.config/nvim
ln -sf ${base}/lazygit ~/.config/lazygit
