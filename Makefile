.POSIX:
	
.PHONY: all FRC

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

# MISC
# ----

FRC:
