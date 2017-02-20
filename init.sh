#!/bin/bash

if [ -d literate-tools ]; then
    echo "literate-tools already present"
    (cd literate-tools; git pull)
else
    git clone https://github.com/vlead/literate-tools.git
fi

if [ -L tangle-make ]; then
    echo "symlinked makefile already present"
else 
    ln -sf literate-tools/makefile tangle-make
fi

