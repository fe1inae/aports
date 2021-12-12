# VARIABLES
# ---------

SRC=$(wildcard felports/*)

DIR=$(realpath packages)

# RULES
# -----

all: $(SRC)

felports/%: FRC
	@cd $(@) \
		&& abuild \
			-P $(DIR) \
			index

# MISC
# ----
.PHONY: all FRC

FRC:

