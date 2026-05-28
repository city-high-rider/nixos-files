#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nix/dotfiles"
CONFIG="$HOME/.config"

mkdir -p "$CONFIG"

link_file() {
    local src="$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        echo "exists (symlink): $dst"
        return
    fi

    if [ -e "$dst" ]; then
        echo "exists (real file): $dst"
        return
    fi

    echo "linking $dst -> $src"
    ln -s "$src" "$dst"
}

link_file \
    "$DOTFILES/helix/config.toml" \
    "$CONFIG/helix/config.toml"

link_file \
    "$DOTFILES/helix/languages.toml" \
    "$CONFIG/helix/languages.toml"

link_file \
    "$DOTFILES/kitty/kitty.conf" \
    "$CONFIG/kitty/kitty.conf"
    
link_file \
    "$DOTFILES/niri/config.kdl" \
    "$CONFIG/niri/config.kdl"

