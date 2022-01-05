.POSIX:
	
.PHONY: all rss FRC

# VARIABLES
# ---------

SRC=                       \
	src/fel/stagit-gemini  \
	src/fel/vim            \
	src/main/astronaut     \
	src/main/diagon        \
	src/main/didder        \
	src/main/kineto        \
	src/main/lr            \
	src/main/nq            \
	src/main/rwc           \
	src/main/unscii        \
	src/main/xe

DIR=$(HOME)/pkg/pub
ARCH=x86_64

# RULES
# -----

all: $(SRC)

$(SRC): FRC
	@PATH="$(PWD)/bin:$$PATH"                                        \
		&& cd $(@)                                                   \
			&& abuild sanitycheck                                    \
			&& apkbuild-shellcheck APKBUILD                          \
			&& apkbuild-lint APKBUILD                                \
			&& mkdir -p $(DIR)/$(notdir $(@D))/$(ARCH)               \
			&& mkdir -p $(notdir $(@D))                              \
			&& cp $(PWD)/repos $(notdir $(@D))/.rootbld-repositories \
			&& abuild -P $(DIR) rootbld                              \
			&& abuild -P $(DIR) index
	@rm -rf $(@)/$(notdir $(@D))

rss: rss/read.txt
	@SFEED_URL_FILE=rss/read.txt    \
		&& sfeed_update rss/sfeedrc \
		&& sfeed_curses rss/raw/*

rss/read.txt:
	mkdir -p rss
	touch rss/read.txt

# MISC
# ----

FRC:
