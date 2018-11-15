#!/usr/bin/env bash
# ----------------------------------------------------------
# Register aliases for the `main.sh` dev commander script.
# This file should be loaded with `source`, ideally in your
# shell init file.
# ----------------------------------------------------------

SCRIPT_PATH="$(dirname $0)/main.sh"

alias dcd="${SCRIPT_PATH}"
alias dev="${SCRIPT_PATH} dev"
alias install="${SCRIPT_PATH} install"
alias build="${SCRIPT_PATH} build"
alias db:migrate="${SCRIPT_PATH} db:migrate"

alias commit="${SCRIPT_PATH} commit"
alias amend="${SCRIPT_PATH} amend"
alias push="${SCRIPT_PATH} push"
alias add="${SCRIPT_PATH} add"
alias status="${SCRIPT_PATH} status"
