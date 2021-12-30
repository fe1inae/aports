# VARIABLES
# ---------

SRC=               \
	main/astronaut \
	main/diagon    \
	main/didder    \
	main/kineto    \
	main/lr        \
	main/nq        \
	main/rwc       \
	main/unscii    \
	main/vim       \
	main/xe        

KEY=$(HOME)/.abuild/felinae@ulthar.cat-61c9223c.rsa
DIR=$(HOME)/pkg/pub

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

.PHONY: all FRC

FRC:

