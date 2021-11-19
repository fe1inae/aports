#!/bin/sh -e

SCRIPT="$(readlink -f "$0")"
SRC="${SCRIPT%%/make}/felports"
PKG="${SCRIPT%%/make}/packages"

for dir in "$SRC"/*; do
	cd "$dir" && \
		abuild -P "$PKG"
done

printf 'done\n'
