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
SHARDS := shards
CRFLAGS :=
FIND := find
MAKE += --no-print-directory
DESTDIR :=
PREFIX := /usr/local
BINDIR := $(DESTDIR)$(PREFIX)/bin
SOURCES := $(shell $(FIND) src -type f -name '*.cr' 2>&-||:)
SPECS := $(shell $(FIND) spec -type f -name '*.cr' 2>&-||:)
SPEC_NAME := spec
SPEC_TARGET := spec/crypt_spec.cr
OUT := bin
SPEC_BIN := $(OUT)/$(SPEC_NAME)
SAMPLE_BINS := $(foreach f,$(shell $(FIND) sample -type f),$(OUT)/$(basename $f))

stats ?= ### Enable statistics output
debug ?= ### Add symbolic debug info
static ?= ### Enable static linking
threads ?= ### Maximum number of threads to use
verbose ?= ### Run specs in verbose mode
release ?= ### Compile in release mode
no_debug ?= ### Skip any symbolic debug info
progress ?= ### Enable progress output
junit_out ?= ### Directory to output junit results

override CRFLAGS += $(if $(release),--release )$(if $(stats),--stats )$(if $(progress),--progress)
override CRFLAGS += $(if $(debug),-d )$(if $(no_debug),--no-debug)
override CRFLAGS += $(if $(static),--static )$(if $(threads),--threads $(threads))
override CRFLAGS := $(strip $(CRFLAGS))
override SPEC_FLAGS += $(strip $(if $(verbose),--verbose )$(if $(junit_out),--junit_output $(junit_out)))

all: spec 

samples: $(SAMPLE_BINS)

cr_build = $(strip $(CRYSTAL) build $(CRFLAGS))

ifdef CRFLAGS
$(PROG_BIN): phony
endif
$(PROG_BIN): $(SOURCES)
	$(SHARDS) install
	mkdir -p $(@D)
	$(cr_build) -o $@ $(PROG_TARGET)

test: spec
spec: $(SPEC_BIN)
	$(SPEC_BIN)

ifdef SPEC_FLAGS
$(SPEC_BIN): phony
endif
$(SPEC_BIN): $(SOURCES) $(SPECS)
	$(SHARDS) install
	mkdir -p $(@D)
	$(strip $(cr_build) -o $@ $(SPEC_TARGET) -- $(SPEC_FLAGS))

ifdef CRFLAGS
$(OUT)/sample/%: sample/%.cr phony
else
$(OUT)/sample/%: sample/%.cr
endif
	$(cr_build) -o $@ $<

shards: phony
	$(SHARDS) install

clean: phony
	rm -f $(PROG_NAME) $(ignore_errors)
	rm -f $(SPEC_NAME) $(ignore_errors)

touch: phony
	touch $(PROG_TARGET)

docs: phony
	$(CRYSTAL) docs

# For order of things
all_with_env: 
	$(MAKE) all

phony:
