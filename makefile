#SHELL := /bin/bash
BUILD_DIR=build

VER_BRANCH=build-release
VER_FILE=VERSION

LITERATE_TOOLS="https://github.com/vlead/literate-tools.git"
LITERATE_DIR=literate-tools
ELISP_DIR=elisp
ORG_DIR=org-templates
STYLE_DIR=style
CODE_DIR=build/code
DOC_DIR=build/docs
SRC_DIR=src
PWD=$(shell pwd)
LINT_FILE=${PWD}/${CODE_DIR}/lint_output
EXIT_FILE=${PWD}/exit.txt
STATUS=0

all:  build run-py-tests

clean-literate:
	rm -rf ${ELISP_DIR}
	rm -rf src/${ORG_DIR}
	rm -rf src/${STYLE_DIR}

pull-literate-tools:
	@echo "pulling literate support code"
	echo ${PWD}
ifeq ($(wildcard elisp),)
	@echo "proxy is..."
	echo $$http_proxy
	git clone ${LITERATE_TOOLS}
	mv ${LITERATE_DIR}/${ELISP_DIR} .
	mv ${LITERATE_DIR}/${ORG_DIR} ${SRC_DIR}
	mv ${LITERATE_DIR}/${STYLE_DIR} ${SRC_DIR}
	rm -rf ${LITERATE_DIR}
else
	@echo "Literate support code already present"
endif

init: pull-literate-tools
	rm -rf ${BUILD_DIR}
	mkdir -p ${BUILD_DIR} ${CODE_DIR}

build: init write-version
	emacs  --script elisp/publish.el


ign:
	rsync -a ${SRC_DIR}/${ORG_DIR} ${BUILD_DIR}/docs
	rsync -a ${SRC_DIR}/${STYLE_DIR} ${BUILD_DIR}/docs
	rm -f ${BUILD_DIR}/docs/*.html~

# get the latest commit hash and its subject line
# and write that to the VERSION file
write-version:
	echo -n "Built from commit: " > ${CODE_DIR}/${VER_FILE}
	echo `git rev-parse HEAD` >> ${CODE_DIR}/${VER_FILE}
	echo `git log --pretty=format:'%s' -n 1` >> ${CODE_DIR}/${VER_FILE}

install-pep:
	sudo pip install pep8

lint:  install-pep
	(pep8 --ignore=E302 ${PWD}/${CODE_DIR} > ${LINT_FILE}; ([ $$? -eq 0 ] && echo "no lint errors!") || echo "lint errors exist!")

build-with-lint: build lint

run-py-tests:
	export PYTHONPATH=${PWD}/${CODE_DIR}; find ${PWD}/${CODE_DIR} -name '*test_*.py' -exec python '{}' \;

clean:	clean-literate
	rm -rf ${BUILD_DIR}

