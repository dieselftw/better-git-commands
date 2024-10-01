#### Git commands are kinda garbage so I made my own

## General isntallation instructions

1. Clone the repo
2. Run `cd better-git commands`
3. Run `chmod +x *`.
4. Paste the commands you need to `~/.local/bin/`.
5. [OPTIONAL] Add your GitHub API key. Run it while in the bin directory. Remember to replace `YOUR_API_KEY` with your actual key.
```bash
find . -name "*.sh" -type f -exec sed -i 's/^.*better_git_commands_api_key[[:space:]]*=.*$/better_git_commands_api_key=YOUR_API_KEY/' {} +
```

## Available commands

1. `git c` : `git clone` with repo size and general metadata added.
