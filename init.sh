#!/usr/bin/env bash
# ----------------------------------------------------------
# Register aliases for the `main.sh` dev commander script.
# This file should be loaded with `source`, ideally in your
# shell init file.
# ----------------------------------------------------------

SCRIPT_PATH="$(dirname $0)/main.sh"

alias dcd="${SCRIPT_PATH}"

function registerAlias()
{
  alias "$1"="dcd $1"
}

# Git
registerAlias commit
registerAlias amend
registerAlias push
registerAlias add
registerAlias status

# Project-specific
registerAlias dev
registerAlias install
registerAlias build
registerAlias dbmigrate
