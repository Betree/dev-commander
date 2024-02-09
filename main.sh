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
  echo " > dcd dbmigrate"
  echo " > dcd commit"
  echo " > dcd amend"
  echo " > dcd push"
  echo " > dcd add"
  echo " > dcd status"
  echo " > dcd stash"
  echo " > dcd pop"
  exit 1
fi

# ---- Utils ----

function commandNotFound!() {
  echo "🦍 [D3v c0mm4nd3r] Command not found"
  echo "If you would expected this to work, you should open a PR on https://github.com/Betree/dev-commander with your use case."
  exit 1
}

function run!() {
  "$@"
  exit $?
}

function exitIfNotGit() {
  if [ -z ".git" ]; then
    echo "Command ${1} can only be run in a git repository."
    exit 1
  fi
}

function confirm() {
  echo -n "$@"
  read -e answer
  for response in y Y yes YES Yes Sure sure SURE OK ok Ok; do
    if [ "$answer" == "$response" ]; then
      return 0
    fi
  done

  # Any answer other than the list above is considerred a "no" answer
  return 1
}

# Exit if the main branch is checked out, unless explicitly allowed
function exitIfMainBranch() {
  if [ "$(git rev-parse --abbrev-ref HEAD)" == "$(getMainBranch)" ]; then
    confirm "Are you sure you want to run ${1} on the main branch? [y/N] " || exit 0
  fi
}

function runGitCommand!() {
  exitIfNotGit $1
  run! git "$@"
}

function runGitCommandUnlessMain!() {
  exitIfNotGit $1
  exitIfMainBranch $1
  run! git "$@"
}

function getMainBranch() {
  git remote show origin | awk '/HEAD branch/ {print $NF}'
}

# ---- 🦍 ----

if [ "$1" == "🦍" ]; then run! echo "🦍 Different projects, same commands. 🦍"; fi

# ---- Git commands are not project-specific ----

if [ "$1" == "commit" ]; then
  runGitCommandUnlessMain! commit "${@:2}"
elif [ "$1" == "checkout" ]; then
  runGitCommand! checkout "${@:2}"
elif [ "$1" == "amend" ]; then
  runGitCommandUnlessMain! commit --amend
elif [ "$1" == "first-push" ]; then
  runGitCommandUnlessMain! push -u origin HEAD "${@:2}"
elif [ "$1" == "push" ]; then
  runGitCommandUnlessMain! push "${@:2}"
elif [ "$1" == "pushf" ]; then
  runGitCommandUnlessMain! push --force-with-lease "${@:2}"
elif [ "$1" == "add" ]; then
  runGitCommand! add "${@:2}"
elif [ "$1" == "status" ]; then
  runGitCommand! status
elif [ "$1" == "stash" ]; then
  runGitCommand! stash
elif [ "$1" == "pop" ]; then
  runGitCommand! pop
elif [ "$1" == "reset-soft" ]; then
  runGitCommandUnlessMain! reset --soft HEAD~1
elif [ "$1" == "reset-to-remote-hard" ]; then
  runGitCommandUnlessMain! fetch && runGitCommandUnlessMain! reset --hard @{u}
elif [ "$1" == "pull" ]; then
  runGitCommand! pull
elif [ "$1" == "pull-main" ]; then
  exitIfNotGit
  git stash && git checkout "$(getMainBranch)" && git pull
  exit $?
elif [ "$1" == "pull-staging" ]; then
  exitIfNotGit
  git stash && git checkout staging && git pull
  exit $?
elif [ "$1" == "deploy-staging" ]; then
  exitIfNotGit
  git stash && git checkout "$(getMainBranch)" && git pull && npm run deploy:staging
  exit $?
elif [ "$1" == "deploy-production" ]; then
  exitIfNotGit
  npm run deploy:production
  exit $?
elif [ "$1" == "move-to-branch" ]; then
  exitIfNotGit
  git stash && git checkout "$(getMainBranch)" && git pull && git checkout -b $2 && git stash pop
  exit $?
elif [ "$1" == "rebase-on-main" ]; then
  exitIfNotGit
  pull-main && git checkout $2 && git stash pop && git rebase main
  exit $?
fi

# ---- Project-specific commands ----

if [ -f "package.json" ]; then
  if [ "$1" == dev ]; then
    npm run dev "${@:2}"
  elif [ "$1" == install ]; then
    npm install "${@:2}"
  elif [ "$1" == build ]; then
    npm run build
  elif [ "$1" == dbmigrate ]; then
    npm run db:migrate
  else
    commandNotFound!
  fi
elif [ -f "mix.exs" ]; then
  if [ "$1" == dev ]; then
    iex -S mix
  elif [ "$1" == install ]; then
    mix deps.get
  elif [ "$1" == build ]; then
    mix compile
  elif [ "$1" == dbmigrate ]; then
    mix ecto.migrate
  else
    commandNotFound!
  fi
else
  echo "🦍 [D3v c0mm4nd3r] Error: Unknown project type."
  echo "If you would expected this to work, you should open a PR on https://github.com/Betree/dev-commander with your use case."
  exit 1
fi
