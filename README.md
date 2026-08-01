# Neovim Config

My personal Neovim configuration, originally based on [ThePrimeagen/init.lua](https://github.com/ThePrimeagen/init.lua), with various customizations and additional plugins.

## Requirements

- Neovim v0.12
- tree-sitter-cli
- ripgrep
- GNU sed

### Optional: AI assistant (CodeCompanion)

If you want to use the default configuration included in this repository, you also need:

- Codex CLI
- codex-acp
- An OpenAI-compatible API available at `http://127.0.0.1:11434` (e.g. [LiteLLM](https://github.com/BerriAI/litellm))

The AI-related configuration (providers, models, and API endpoint) is located in `lua/config/lazy/ai.lua` and can be customized to match your setup.

## Installation

Clone the repository into your Neovim configuration directory:

```sh
git clone https://github.com/sadra1f/nvim-config.git ~/.config/nvim
```

Start Neovim and allow the plugin manager to install the required plugins.

## Keymaps

This configuration uses `<Space>` as the leader key.

Press `<Space>` followed by `?` to open a searchable list of all available keymaps.

## Notes

This configuration is primarily developed and tested on Linux. Some features may depend on Unix utilities such as `ripgrep` and GNU `sed`.
