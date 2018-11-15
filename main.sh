#!/usr/bin/env bash
# ----------------------------------------------------------
# 🦍 Dev commander main entrypoint 🦍
# ----------------------------------------------------------

if [ "$#" -lt 1 ]; then
  echo "+---------------------------+"
  echo "| 🦍 [D3v c0mm4nd3r] Usage  |"
  echo "+---------------------------+"
  echo ""
  echo " > dcd dev"
  echo " > dcd install"
  echo " > dcd build"
  echo " > dcd db:migrate"
  echo " > dcd commit"
  echo " > dcd amend"
  exit 1
fi

# ---- Utils ----

function commandNotFound!()
{
  echo "🦍 [D3v c0mm4nd3r] Command not found: ${1}"
  echo "If you would expected this to work, you should open a PR on https://github.com/Betree/dev-commander with your use case."
  exit 1
}

function runGitCommand!()
{
  if [ -z ".git" ]; then
    echo "Command ${1} can only be run in a git repository."
    exit 1
  fi
  git $@
  exit $?
}

# ---- Git commands are not project-specific ----

if [ "$1" == "commit" ]; then runGitCommand! commit "${@:2}"
elif [ "$1" == "amend" ]; then runGitCommand! commit --amend "${@:2}"
elif [ "$1" == "push" ]; then runGitCommand! push "${@:2}"
elif [ "$1" == "add" ]; then runGitCommand! add "${@:2}"
elif [ "$1" == "status" ]; then runGitCommand! status
fi

# ---- Project-specific commands ----

if [ -f "package.json" ]; then
  if   [ "$1" == dev ]; then npm run dev
  elif [ "$1" == install ]; then npm install
  elif [ "$1" == build ]; then npm run build
  elif [ "$1" == db:migrate ]; then npm run db:migrate
  else commandNotFound!
  fi
elif [ -f "mix.exs" ]; then
  if   [ "$1" == dev ]; then iex -S mix
  elif [ "$1" == install ]; then mix deps.get
  elif [ "$1" == build ]; then mix compile
  elif [ "$1" == db:migrate ]; then mix ecto.migrate
  else commandNotFound!
  fi
else
  echo "🦍 [D3v c0mm4nd3r] Error: Unknown project type."
  echo "If you would expected this to work, you should open a PR on https://github.com/Betree/dev-commander with your use case."
  exit 1
fi
