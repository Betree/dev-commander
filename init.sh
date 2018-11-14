#!/usr/bin/env bash
# ----------------------------------------------------------
# Register aliases for the `main.sh` dev commander script.
# This file should be loaded with `source`, ideally in your
# shell init file.
# ----------------------------------------------------------

SCRIPT_PATH="$(dirname $0)/main.sh"

alias dev="${SCRIPT_PATH} dev"
alias install="${SCRIPT_PATH} install"
alias db:migrate="${SCRIPT_PATH} db:migrate"
