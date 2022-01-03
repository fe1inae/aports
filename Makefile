.POSIX:
	
.PHONY: all rss FRC

# VARIABLES
# ---------

SRC=                   \
	fel/stagit-gemini  \
	fel/vim            \
	main/astronaut     \
	main/diagon        \
	main/didder        \
	main/kineto        \
	main/lr            \
	main/nq            \
	main/rwc           \
	main/unscii        \
	main/xe

DIR=$(HOME)/pkg/pub
ARCH=x86_64

# RULES
# -----

all: $(SRC)

$(SRC): FRC
	@mkdir -p $(DIR)/$(@D)/$(ARCH)
	@mkdir -p $(@)/$(@D)
	@cp repos $(@)/$(@D)/.rootbld-repositories
	@cd $(@)                          \
		&& abuild -P $(DIR) rootbld   \
		&& abuild -P $(DIR) index
	@rm -rf $(@)/$(@D)

rss: rss/read.txt
	@SFEED_URL_FILE=rss/read.txt sfeed_update rss/sfeedrc
	@SFEED_URL_FILE=rss/read.txt sfeed_curses rss/raw/*

rss/read.txt:
	mkdir -p rss
	touch rss/read.txt

# MISC
# ----

FRC:
