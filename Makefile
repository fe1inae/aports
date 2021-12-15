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
	main/xe-doc 

DIR=$(XDG_DATA_HOME)/apk

# RULES
# -----

all: $(SRC)

packages:
	mkdir -p packages/felports/x86_64

$(SRC): FRC
	@mkdir -p $(DIR)/$(@D)
	@cd $(@)                  \
		&& abuild sanitycheck \
		&& abuild             \
			-r                \
			-P $(DIR)

# MISC
# ----

SYNC:
	git pull --force
	$(MAKE)

.PHONY: all FRC SERV

FRC:

