MKSHELL=rc

# VARIABLES
# =========

DIR  = $PUBLIC/apk
ARCH = x86_64

# SOURCES
# =======

SRC=src/fel/stagit-gemini  \
	src/main/astronaut     \
	src/main/diagon        \
	src/main/parinfer-rust \
	src/main/didder        \
	src/main/kineto        \
	src/main/lr            \
	src/main/nq            \
	src/main/rwc           \
	src/main/unscii        \
	src/main/xe

# RULES
# =====

all:V: build

test:QV:
	path=($PWD/bin $path)
	for (target in $SRC) {
		cd $target
		# sanity check
		# ------------
		abuild sanitycheck
		apkbuild-shellcheck APKBUILD
		apkbuild-lint APKBUILD
		# cleanup
		# -------
		cd $PWD
	}

build:QV: test
	path=($PWD/bin $path)
	for (target in $SRC) {
		cd $target
		# make output dirs
		# ----------------
		middle = `{printf $target | 9 sed 's;^[^/]*/(.*)/[^/]*$;\1;'}
		tmp    = `{printf $middle | 9 sed 's;.*/([^/]*)$;\1;'}
		mkdir -p $DIR/$middle/$ARCH
		mkdir -p $tmp
		# build
		# -----
		cp $PWD/etc/repos $tmp/.rootbld-repositories
		abuild -P $DIR rootbld
		abuild -P $DIR index
		# cleanup
		# -------
		rm -rf $tmp
		cd $PWD
	}

rss:QV: rss/read.txt
	SFEED_URL_FILE = rss/read.txt
	sfeed_update rss/sfeedrc
	sfeed_curses rss/raw/*

rss/read.txt:Q:
	mkdir -p rss
	touch rss/read.txt

