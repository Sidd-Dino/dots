#!/bin/sh

export CFLAGS="-O3 -pipe -march=native -mtune=generic"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j7"
export CMAKE_GENERATOR=Ninja
export PATH="$PATH:$HOME/bin"
export ENV="$HOME/.rc"
