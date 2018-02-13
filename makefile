.PHONY: spec sample build-sample docs help clean

args = $(filter-out $@,$(MAKECMDGOALS))
	
spec:
	crystal spec

clean:
	rm -rf docs && rm -rf bin/*

docs:
	crystal docs

sample:
	crystal run samples/$(args).cr

build-sample: 
	crystal build -o bin/$(args) samples/$(args).cr


# This makes makefile ignore 
# rules that are not defined,
# makes rules able to take args
%:
	@:


# https://gist.github.com/prwhite/8168133 "Help target"
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\$$//' | sed -e 's/##//'

spec:         ## Runs all specs
docs:         ## Generates docs
sample:       ## Run specified sample
build-sample: ## Builds specified sample to bin
help:         ## Show this help.