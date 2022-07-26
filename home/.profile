#!/bin/sh

export CFLAGS="-O3 -pipe -march=native -mtune=generic"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j7"

export CMAKE_GENERATOR=Ninja

export KISS_PATH=
# export KISS_SU=ssu
# export KISS_GET=axel
KISS_PATH="$HOME/.kiss/repo/core"
KISS_PATH="$KISS_PATH:$HOME/.kiss/kiss-xorg/xorg"
KISS_PATH="$KISS_PATH:$HOME/.kiss/kiss-xorg/extra"
KISS_PATH="$KISS_PATH:$HOME/.kiss/kiss-xorg/community"
KISS_PATH="$KISS_PATH:$HOME/.kiss/community/community"
KISS_PATH="$KISS_PATH:$HOME/.kiss/repo/extra"

export PS1="% "

export ENV="$HOME/.rc"
