SHELL := /bin/bash

CODE_DIR=build/code
DOC_DIR=build/docs
PWD=$(shell pwd)
LINT_FILE=${PWD}/${CODE_DIR}/lint_output
EXIT_FILE=${PWD}/exit.txt
STATUS=0

all:  build run-py-tests

init: 
	./init.sh

build: init
	make -f tangle-make -k all

install-pep:
	sudo pip install pep8

lint:  install-pep
	pep8 --ignore=E302 ${PWD}/${CODE_DIR} > ${LINT_FILE};

build-with-lint: build lint

run-py-tests:
	export PYTHONPATH=${PWD}/${CODE_DIR}; find ${PWD}/${CODE_DIR} -name '*test_*.py' -exec python '{}' \;

clean:	
	make -f tangle-make clean
