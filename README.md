# 🦍 D3v c0mm4nd3r

Always use the same language-agnostic commands to develop accross your projects.
This script will auto-detect your project type based on files presence (`package.json`
for npm, `mix.exs` for Elixir...).

Currently supported project types:

- Elixir (mix)
- NodeJS (npm)

## Install

```bash
git clone https://github.com/Betree/dev-commander.git ~/.dev-commander

# If using bash
echo "# dev-commander\nsource ~/.dev-commander/main.sh" >> ~/.bashrc

# If using zsh
echo "# dev-commander\nsource ~/.dev-commander/main.sh" >> ~/.zshrc
```

## Use

- `dev` Run the development server or the app binary
- `install` Install dependencies
- `db:migrate` Migrate database

## Configure

[TODO]