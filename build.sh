#!/bin/sh
set -eux

# VARIABLES
# =========

DIR="${PUBLIC:-"${HOME}/var"}/apk"
ARCH="$(uname -m)"

# SOURCES
# =======

SRC="$(find src -name APKBUILD | sed 's;/[^/]*$;;')"

# RULES
# =====

build()
{
	PATH="$PWD/bin:$PATH"
	for target in $SRC
	do
		# set variables
		# -------------
		middle="$(printf $target | sed -E 's;^[^/]*/(.*)/[^/]*$;\1;')"
		export APKBUILD="$PWD/$target/APKBUILD"
		export SRCDEST="$PWD/$target/tmp"
		export APORTSDIR="$PWD/src"
		# sanith check
		# ------------
		abuild sanitycheck
		apkbuild-shellcheck "$APKBUILD"
		# prepare
		# -------
		# create dirs
		mkdir -p "$DIR/$middle/$ARCH"
		# add/update repositories
		cp -f /etc/apk/repositories "$PWD/src/$middle/.rootbld-repositories"
		# build
		# -----
		abuild -P "$DIR" rootbld
		abuild -P "$DIR" index
	done
}

rss()
{
	mkdir -p rss
	touch rss/read.txt
	export SFEED_URL_FILE=rss/read.txt
	sfeed_update rss/sfeedrc > /dev/null 2>&1
	sfeed_curses rss/raw/*
}


case "${1:-build}" in
r*) rss ;;
b*) build ;;
esac
