#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/nix/dotfiles"

find "$DOTFILES" \
    -path "$DOTFILES/.git" -prune -o \
    -type f -print |
while read -r src; do

    rel="$(realpath --relative-to="$DOTFILES" "$src")"
    dst="$HOME/$rel"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        current="$(readlink "$dst")"

        if [ "$current" = "$src" ]; then
            echo "exists: $dst"
        else
            echo "wrong symlink: $dst"
        fi

        continue
    fi

    if [ -e "$dst" ]; then
        echo "exists (real file): $dst"
        continue
    fi

    echo "linking $dst -> $src"
    ln -s "$src" "$dst"
done
