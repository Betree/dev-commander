# 🦍 D3v c0mm4nd3r

Stop confusing your commands and using `npm run` in your Elixir projects.
Always use the same language-agnostic commands to run your developement commands.

This script will auto-detect your project type based on files presence (`package.json`
for npm, `mix.exs` for Elixir...).

Currently supported project types:

- Elixir (mix)
- NodeJS (npm)

## Install

```bash
# Clone the project to your home folder
git clone https://github.com/Betree/dev-commander.git ~/.dev-commander

# At this to your `~/.bashrc`, `~/.zshrc` or wherether your shell config is
source ~/.dev-commander/init.sh

# If you're a weak person and want to disable short aliases to only use
# commander with the `dcd` command, you can use this instead
source ~/.dev-commander/init_without_aliases.sh
```

## Use

Commands try to be as simple and short as possible, but we may add the `-dc`
suffix to some of them if mean people already reserved the keyword (for exemple `test` ).

- `dev` Run the development server or the app binary
- `install` Install dependencies
- `build` Build or compile project
- `db:migrate` Migrate database

## Configuration

Not yet.
