
#!/usr/bin/env make -f
#
# General Makefile for a crystal program.
# For it to work, you want to change PROG_NAME to your programs name.
# You should also ensure PROG_TARGET and SPEC_TARGET
# are respectively the programs entry file, and the specs entry file.

.POSIX:
.ONESHELL:

SHELL := sh

CRYSTAL := crystal
SHARDS  := shards
CRFLAGS :=
FIND    := find
MAKE    += --no-print-directory

DESTDIR =
PREFIX := /usr/local
BINDIR := $(DESTDIR)$(PREFIX)/bin

ignore_errors := 2>&-||: 
SOURCES := $(shell $(FIND) src  -type f -name '*.cr' $(ignore_errors))
SPECS   := $(shell $(FIND) spec -type f -name '*.cr' $(ignore_errors))
SAMPLES := $(shell $(FIND) sample -type f -name '*.cr' $(ignore_errors))

SPEC_NAME := spec

SPEC_TARGET := spec/crypt_spec.cr

OUT := bin

SPEC_BIN := $(OUT)/$(SPEC_NAME)

# These are set empty so commandline completion (if installed) 
# detects them; E.g. '$ make v<tab>' completes to 'verbose='
stats     ?= ### Enable statistics output
debug     ?= ### Add symbolic debug info
static    ?= ### Enable static linking
threads   ?= ### Maximum number of threads to use
verbose   ?= ### Run specs in verbose mode
release   ?= ### Compile in release mode
no_debug  ?= ### Skip any symbolic debug info
progress  ?= ### Enable progress output
junit_out ?= ### Directory to output junit results

override CRFLAGS += $(if $(release),--release )$(if $(stats),--stats )$(if $(progress),--progress)
override CRFLAGS += $(if $(debug),-d )$(if $(no_debug),--no-debug)
override CRFLAGS += $(if $(static),--static )$(if $(threads),--threads $(threads))
override CRFLAGS := $(strip $(CRFLAGS))

override SPEC_FLAGS += $(strip $(if $(verbose),-v )$(if $(junit_out),--junit_output $(junit_out)))

all: $(PROG_BIN)

install: phony
install: export release  := 1
install: export no_debug := 1
install: all_with_env
	chmod 755 $(PROG_BIN)
	cp $(PROG_BIN) $(BINDIR)

uninstall: phony
		rm -f $(BINDIR)/$(PROG_NAME)

cr_build = $(strip $(CRYSTAL) build $(CRFLAGS) -o $@)

ifdef CRFLAGS
$(PROG_BIN): phony
endif
$(PROG_BIN): $(SOURCES)
	$(SHARDS) install
	mkdir -p $(@D)
	$(cr_build) $(PROG_TARGET)

test: spec
spec: $(SPEC_BIN)
	$(SPEC_BIN)

ifdef SPEC_FLAGS
$(SPEC_BIN): phony
endif
$(SPEC_BIN): $(SOURCES) $(SPECS)
	$(SHARDS) install
	mkdir -p $(@D)
	$(cr_build) $(SPEC_FLAGS) $(SPEC_TARGET)

shards: phony
	$(SHARDS) install

clean: phony
	rm -f $(PROG_NAME) $(ignore_errors)
	rm -f $(SPEC_NAME) $(ignore_errors)

touch:
	touch $(PROG_TARGET)

# For order of things
all_with_env: 
	$(MAKE) all

phony: