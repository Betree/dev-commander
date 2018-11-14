#!/usr/bin/env bash
# ----------------------------------------------------------
# 🦍 Dev commander main entrypoint 🦍
# ----------------------------------------------------------

if [ "$#" -lt 1 ]; then
  echo "🦍 [dev-commander] You're doing it wrong."
  exit 1
fi

if [ -f "package.json" ]; then
  if   [ "$1" == dev ]; then npm run dev
  elif [ "$1" == install ]; then npm install
  elif [ "$1" == build ]; then npm run build
  elif [ "$1" == db:migrate ]; then npm run db:migrate
  fi
elif [ -f "mix.exs" ]; then
  if   [ "$1" == dev ]; then iex -S mix
  elif [ "$1" == install ]; then mix deps.get
  elif [ "$1" == build ]; then mix compile
  elif [ "$1" == db:migrate ]; then mix ecto.migrate
  fi
else
  echo "🦍 [dev-commander] Error: Unknown project type."
  echo "If you would expected this to work, you should open a PR on https://github.com/Betree/dev-commander with your use case."
  exit 1
fi
