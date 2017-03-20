#!/bin/bash

if [ -d literate-tools ]; then
    echo "literate-tools already present"
    (cd literate-tools; git pull; git checkout readtheorg)
else
    git clone https://github.com/vlead/literate-tools.git
    (cd literate-tools; git checkout readtheorg)
fi

if [ -L tangle-make ]; then
    echo "symlinked makefile already present"
else 
    ln -sf literate-tools/makefile tangle-make
fi

