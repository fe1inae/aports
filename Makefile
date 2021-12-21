# VARIABLES
# ---------

SRC=               \
	main/lr        \
	main/lr-doc    \
	main/nq        \
	main/nq-doc    \
	main/rwc       \
	main/rwc-doc   \
	main/xe        \
	main/xe-doc    \
	main/gmnigit   \
	main/kineto    \
	main/telescope

DIR:=$(PWD)/apk

ARCH=x86_64

# RULES
# -----

all: $(SRC)

$(SRC): FRC
	@mkdir -p $(DIR)/$(@D)/$(ARCH)
	@mkdir -p $(@)/main
	@cp repos $(@)/main/.rootbld-repositories
	@cd $(@)                  \
		&& abuild sanitycheck \
		&& abuild             \
			-P $(DIR)         \
			rootbld
	@rm -rf $(@)/main

# MISC
# ----

sync:
	git pull
	$(MAKE)

.PHONY: all sync FRC

FRC:

