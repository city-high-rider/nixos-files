#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nix/dotfiles"
CONFIG="$HOME/.config"

find "$DOTFILES" -type f | while read -r src; do
    rel="${src#$DOTFILES/}"
    dst="$CONFIG/$rel"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        echo "exists (symlink): $dst"
        continue
    fi

    if [ -e "$dst" ]; then
        echo "exists (real file): $dst"
        continue
    fi

    echo "linking $dst -> $src"
    ln -s "$src" "$dst"
done

