# Neovim Configuration for Dart Development �

My Neovim (`0.11+`) setup optimized for **Dart** development, using native LSP (no third-party LSP plugins), `lazy.nvim` for package management, and a curated selection of plugins.

## Features ✨

- 🎨 **Theme**: `catppuccin` (soothing colorscheme)
- ⚡ **Fast**: Lazy-loaded plugins with `lazy.nvim`
- 🧩 **Native LSP**: No wrapper plugins (pure `nvim-lspconfig`)
- 🛠 **Essential Tools**:
  - File explorer: `neo-tree.nvim`
  - Fuzzy finder: `telescope.nvim`
  - Snippets & completions: `nvim-cmp` ecosystem
  - Quality-of-life: autopairs, window picker, which-key

## Plugins 📦

### Core
| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin manager |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/linter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridge between Mason and LSP |

### UI
| Plugin | Purpose |
|--------|---------|
| [catppuccin](https://github.com/catppuccin/nvim) | Soothing pastel theme |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Filetype icons |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybindings helper |

### Editing
| Plugin | Purpose |
|--------|---------|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completions |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | Path completions |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets |

### Utilities
| Plugin | Purpose |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utilities |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI components |
| [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker) | Window selection |

### Language
| Plugin | Purpose |
|--------|---------|
| [flutter-tools.nvim](https://github.com/nvim-flutter/flutter-tools.nvim) | Dart e Flutter |

## LSP Support 🌐

- `dart` (via plugin flutter-tools.nvim)
- `bashls`
- `lua_ls`
- `yamlls`

All managed through `mason.nvim` + native `nvim-lspconfig`.

## Installation 💻

1. Backup your old config:
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```
2. Clone this repo:
   ```sh
   git clone https://github.com/rauleite/dart-nvim ~/.config/nvim
   ```
3. Start Neovim and let lazy.nvim auto-install plugins:
   ```sh
   nvim
   ```
### LSP-Specific Requirements

| LSP        | Dependencies                                                                 | Installation                                                                                     |
|------------|------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| `dart`     | Flutter SDK                                                                  | [Flutter SDK](https://docs.flutter.dev/get-started/install)                                                            |
| `bashls`   | shellcheck (required)<br>• shfmt (recommended)                               | [Instructions](https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies) |
| `lua_ls`   | None                                                                         | –                                                                                                |
| `yamlls`   | None                                                                         | –                                                                                                |

