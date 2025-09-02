# Neovim Config

This is a modular Neovim configuration using Vimscript and vim-plug. It splits settings into small files under `config/` and loads them from `init.vim`.

## Layout

- `init.vim`: Sources all config modules.
- `config/plugins.vim`: Plugin declarations via vim-plug.
- `config/plugin-config.vim`: Plugin-specific configuration and autocommands.
- `config/options.vim`: Editor options (UI, search, indentation, etc.).
- `config/maps.vim`: Keymaps and leader settings.
- `config/cheatsheet.vim`: In-editor cheatsheet (scratch buffer) and `:Cheatsheet` command.

## Prerequisites

- Neovim 0.5+ recommended
- vim-plug (see [vim-plug install instructions](https://github.com/junegunn/vim-plug))
- For `coc.nvim` features, ensure you have Node.js (>= 14) installed

## Install

1. Place/clone this folder at `~/.config/nvim` (macOS/Linux).
2. Open Neovim and install plugins with `:PlugInstall`.
3. Restart Neovim.

## Plugins

Declared in `config/plugins.vim`:

- `preservim/nerdtree` — File explorer
- `jistr/vim-nerdtree-tabs` — Tabs integration for NERDTree
- `Xuyuanp/nerdtree-git-plugin` — Git status in NERDTree
- `akinsho/bufferline.nvim` (v2) — Bufferline UI (requires `set termguicolors`)
- `ctrlpvim/ctrlp.vim` — Fuzzy file finder
- `airblade/vim-gitgutter` — Git signs in the gutter
- `majutsushi/tagbar` — Tags sidebar
- `neoclide/coc.nvim` (release) — LSP/intellisense
- `projekt0n/github-nvim-theme` — Theme
- `morhetz/gruvbox` — Theme
- `github/copilot.vim` — GitHub Copilot suggestions
- `CopilotC-Nvim/CopilotChat.nvim` — Chat with Copilot inside Neovim ([repo](https://github.com/CopilotC-Nvim/CopilotChat.nvim))

Run `:PlugInstall` after first launch to fetch them.

## Keymaps

Leader key: `;`

Window navigation:
- `<leader><Up>` / `<leader><Down>` / `<leader><Left>` / `<leader><Right>` — Move between splits

Buffers:
- `<leader>[` — Previous buffer
- `<leader>]` — Next buffer
- `<leader>x` — Close current buffer (keeps window)

Clipboard:
- Visual `Ctrl-c` — Copy to system clipboard
- Visual `Ctrl-x` — Cut to system clipboard
- Visual `Ctrl-v` / Insert `Ctrl-v` — Paste from system clipboard

Editing:
- `<leader>d` — Duplicate current line
- `jj` in insert mode — Escape

Plugins:
- `Ctrl-p` — Open CtrlP
- `<leader>t` — Toggle Tagbar
- `<leader>n` — Toggle NERDTree (tab-aware)
- `<leader>cc` — CopilotChat: open chat
- `<leader>ce` — CopilotChat: explain
- `<leader>cf` — CopilotChat: fix
- `<leader>ct` — CopilotChat: generate tests
- `<leader>?` — Open the Cheatsheet

## Options

Indentation:
- Spaces width 2 (`expandtab`, `shiftwidth=2`, `tabstop=2`), `autoindent`, `smartindent`

Search:
- `ignorecase`, `smartcase`, `incsearch`, `hlsearch`

UI:
- `number`, `relativenumber`
- `cursorline`, `laststatus=2`, `wildmenu`, `tabpagemax=50`
- Theme: `colorscheme github_dark`
- Mouse enabled (`mouse=a`)

Folding:
- `foldmethod=indent`, `foldnestmax=3`, disabled by default

Misc:
- `clipboard=unnamed,unnamedplus`, `spell`, `autoread`, `hidden`, `history=1000`, `confirm`

## Cheatsheet

Open the in-editor cheatsheet:

- Command: `:Cheatsheet`
- Mapping: `<leader>?`

It opens a scratch buffer with the most useful keymaps and commands (navigation, buffers, clipboard, editing, Copilot, and CopilotChat).

## NERDTree behavior

On startup, if no file is provided, NERDTree opens automatically. The toggle is tab-aware via `vim-nerdtree-tabs`. Hidden files are shown; `node_modules`, `__pycache__`, and `*.pyc` are ignored. Git decorations are provided via `nerdtree-git-plugin`.

## Bufferline

`bufferline.nvim` v2 is enabled with a minimal setup and requires truecolor: `set termguicolors`.

If you see a startup error related to Bufferline, update plugins and ensure devicons is installed:

- Run `:PlugUpdate`
- Ensure `nvim-tree/nvim-web-devicons` is installed (declared in plugins)

## CtrlP

CtrlP mapping is `Ctrl-p`. Ignore patterns include `node_modules`, `.DS_Store`, and `git`.

## CoC

Install desired language servers, e.g. within Neovim:

```
:CocInstall coc-tsserver coc-json coc-eslint coc-pyright
```

Node.js is required.

## Copilot & CopilotChat

This config includes both GitHub Copilot suggestions and Copilot Chat integration.

### Install/authenticate

1. Install plugins: `:PlugInstall` (first launch).
2. Authenticate Copilot:
   - Run `:Copilot setup` from Neovim and follow the browser flow.
   - Ensure your GitHub account has Copilot access.
3. Optional: Ensure Node.js is installed for best compatibility.

### Usage

- Start chat: `:CopilotChat` or `<leader>cc`
- Explain selection: select text in visual mode, then `:CopilotChatExplain` or `<leader>ce`
- Fix selection: visual select, then `:CopilotChatFix` or `<leader>cf`
- Generate tests: visual select, then `:CopilotChatTests` or `<leader>ct`
- Accept Copilot suggestion: `Ctrl-j` in insert mode (custom mapping)

For more details, see the plugin repo: [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim).

## Theme

Default theme is `github_dark` from `projekt0n/github-nvim-theme`. You can change it in `config/options.vim`.

## Notes

- If `vim-plug` is not installed, follow the instructions at the GitHub repo to install it, then run `:PlugInstall`.
- macOS/Linux path layout is assumed. If you manage config elsewhere, update `init.vim` source paths accordingly.
