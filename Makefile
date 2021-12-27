# VARIABLES
# ---------

SRC=               \
	main/diagon \
	main/lr        \
	main/nq        \
	main/rwc       \
	main/xe        \
	main/kineto    \
	main/astronaut

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

