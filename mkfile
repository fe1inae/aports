MKSHELL=rc

# VARIABLES
# =========

DIR       = $PUBLIC/apk
ARCH      = x86_64

# SOURCES
# =======

SRC=\
	src/font/unscii        \
	src/main/astronaut     \
	src/main/diagon        \
	src/main/didder        \
	src/main/es-shell      \
	src/main/kineto        \
	src/main/parinfer-rust \
	src/lang/pforth        \
	src/main/uxn           \
	src/smol/firth         \
	src/smol/lr            \
	src/smol/nq            \
	src/smol/rwc           \
	src/smol/seconth       \
	src/smol/xe

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
		middle    = `{printf $target | 9 sed 's;^[^/]*/(.*)/[^/]*$;\1;'}
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

