# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview
This is a Neovim configuration using Lazy.nvim as the plugin manager. The configuration is tailored for full-stack development with strong support for Vue.js, TypeScript, Go, PHP, and other web technologies.

## Configuration Structure
- `init.lua` - Main entry point that loads core modules and sets up diagnostics
- `lua/config.lua` - Core Vim settings and options (leader key: `,`)
- `lua/setup-lazy.lua` - Lazy.nvim plugin manager bootstrap
- `lua/keys.lua` - Global keybindings and shortcuts
- `lua/plugins/` - Individual plugin configurations
- `lua/utils/` - Custom utility modules
- `lua/snippets/` - Language-specific snippets
- `templates/` - File templates for Vue and TypeScript

## Key Architecture Components

### Plugin Management
Uses Lazy.nvim for plugin management. All plugins are defined in separate files in `lua/plugins/` and loaded via `require("lazy").setup("plugins")`.

### LSP Configuration
Complex LSP setup in `lua/plugins/lsp.lua` with:
- **Vue.js Support**: Uses vtsls + vue_ls combination with custom TypeScript plugin integration
- **Multi-language Support**: Lua, TypeScript/JavaScript, Go, PHP, JSON, Docker Compose
- **Custom Vue Integration**: Special handling for Vue components with d.ts file resolution via `lua/utils/vue.lua`
- **Mason Integration**: LSP servers managed through Mason

### Completion System
Uses Blink.cmp (`lua/plugins/blink-cmp.lua`) with:
- LSP, path, snippets, and buffer sources
- LuaSnip integration for snippets
- Custom keybindings (Enter preset)
- Disabled in specific contexts (Telescope, Dressing, Avante)

### Key Navigation Features
- **Custom Vue "Go to Definition"**: `gd` uses special logic in `lua/utils/vue.lua` to resolve Vue component imports and bypass d.ts files
- **Navbuddy Integration**: Code structure navigation
- **Telescope Integration**: File finding, live grep, LSP symbols, Git operations

## Common Development Commands

### Plugin Management
- `:Lazy` - Open Lazy.nvim plugin manager
- `:Lazy sync` - Update all plugins
- `:Mason` - Open Mason LSP manager

### LSP Operations
- `gd` - Go to definition (with Vue-specific resolution)
- `K` - Show hover documentation
- `T` - Show diagnostics float
- `<leader>cr` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>cf` - Format buffer
- `<leader>cu` - Find references (Telescope)
- `<leader>cd` - Find definitions (Telescope)
- `<leader>cs` - Document symbols (Telescope)

### File Operations
- `<leader>f` - Find files (with git ignore)
- `<leader>s` - Live grep search
- `<leader>o` - Oil file manager
- `<leader>m` - NvimTree toggle
- `<leader>l` - Buffer list (sorted by last used)

### Git Operations
- `<leader>go` - DiffviewOpen
- `<leader>gw` - DiffviewClose
- `<leader>gf` - Fugit2 interface
- `<leader>gh` - Preview hunk
- `<leader>gs` - Stage hunk
- `<leader>gr` - Reset hunk

## Development Notes

### Vue.js Specific Features
- Custom import resolution for Vue components
- TypeScript plugin integration for Vue files
- Special handling for components.d.ts files
- Emmet support for Vue templates

### Colorscheme and Theming
- Primary: Catppuccin Macchiato
- Fallback: Tokyo Night Storm (commented out)
- Custom highlight groups for Vue directives and constructors

### File Type Handling
- Docker Compose files get special indentation (2 spaces)
- HTTP files are recognized
- Vue files have full TypeScript support

### Key Bindings Philosophy
- Leader key: `,` (comma)
- Consistent prefixes: `<leader>c` for code actions, `<leader>g` for git
- Window navigation: Ctrl+hjkl in insert/terminal mode
- Arrow keys for window switching in normal mode

## Code Style Guidelines

### Comments Policy
- **NEVER add comments to code** - Code should be self-explanatory
- Remove existing comments unless they serve a critical functional purpose
- Prefer descriptive variable and function names over comments
- Only exception: License headers or configuration explanations when absolutely necessary