MKSHELL=rc

# VARIABLES
# =========

DIR  = $PUBLIC/apk
ARCH = `{uname -m}

# SOURCES
# =======

SRC=\
	src/font/unscii        \
	src/lang/pforth        \
	src/lang/uxn           \
	src/main/astronaut     \
	src/main/diagon        \
	src/main/didder        \
	src/main/es-shell      \
	src/main/firth         \
	src/main/kineto        \
	src/main/lr            \
	src/main/nq            \
	src/main/parinfer-rust \
	src/main/rwc           \
	src/main/seconth       \
	src/main/xe

# RULES
# =====

all:V: build

test:QV:
	path=($PWD/bin $path)
	for (target in $SRC) {
		# sanity check
		# ------------
		APKBUILD=$PWD/$target/APKBUILD
		abuild sanitycheck
		apkbuild-shellcheck $APKBUILD
		apkbuild-lint       $APKBUILD
	}

build:QV: test
	path=($PWD/bin $path)
	for (target in $SRC) {
		# set variables
		# -------------
		middle = `{printf $target | $PLAN9/bin/sed 's;^[^/]*/(.*)/[^/]*$;\1;'}
		
		APKBUILD  = $PWD/$target/APKBUILD
		SRCDEST   = $PWD/$target/tmp
		APORTSDIR = $PWD/src
		# prepare
		# ----------------
		# create dirs
		mkdir -p $DIR/$middle/$ARCH
		# add/update repositories
		cp -f /etc/apk/repositories $PWD/src/$middle/.rootbld-repositories
		# build
		# -----
		# run abuild
		abuild -P $DIR rootbld
		abuild -P $DIR index
	}

rss:QV: rss/read.txt
	SFEED_URL_FILE = rss/read.txt
	sfeed_update rss/sfeedrc > /dev/null >[2=1] 
	sfeed_curses rss/raw/*

rss/read.txt:Q:
	mkdir -p rss
	touch rss/read.txt

