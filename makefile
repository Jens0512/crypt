.PHONY: spec
	
spec:
	crystal spec

build: 
	crystal build -o crypt src/crypt.cr
