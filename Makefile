# VARIABLES
# ---------

SRC=\
	main/lr      \
	main/lr-doc  \
	main/nq      \
	main/nq-doc  \
	main/rwc     \
	main/rwc-doc \
	main/xe      \
	main/xe-doc  \
	main/gmnigit 

DIR?=$(XDG_DATA_HOME)/apk

ARCH=x86_64

# RULES
# -----

all: $(SRC)

$(SRC): FRC
	@mkdir -p $(DIR)/$(@D)/$(ARCH)
	@cd $(@)                  \
		&& abuild sanitycheck \
		&& abuild             \
			-r                \
			-P $(DIR)

# MISC
# ----

sync:
	git pull
	$(MAKE)

.PHONY: all sync FRC

FRC:

