#!/bin/sh

export PS1='$ '
export EDITOR=nvim
export LANG=en_US.UTF-8
export CFLAGS="-O3 -pipe -march=native -mtune=generic"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j7"
export CMAKE_GENERATOR=Ninja

export LIBVA_DRIVER_NAME=i965

export XDG_RUNTIME_DIR="/tmp/run-$(id -u)"
mkdir  -p "${XDG_RUNTIME_DIR}"
chmod 700 "${XDG_RUNTIME_DIR}"

conf_dir="${HOME}/.config/shells"

export BASH_ENV="${conf_dir}/bash/rc"
export ENV="${conf_dir}/sh/rc"

unset conf_dir
