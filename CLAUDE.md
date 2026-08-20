# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration targeting **Neovim 0.11.2+**, using **lazy.nvim** as the plugin manager. The namespace is `fere` throughout `lua/fere/`.

## Architecture

### Boot Sequence

`init.lua` is the entry point. It does three things in order:
1. Loads core modules: `fere.remap` (keymaps), `fere.settings` (options), `fere.lsp` (diagnostics + LSP enable)
2. Bootstraps lazy.nvim (auto-clones if missing)
3. Calls `require("lazy").setup({ import = "fere.plugins" })` which auto-discovers all files in `lua/fere/plugins/`

### LSP: Two Separate Systems

**Native LSP (Neovim 0.11+)** -- No nvim-lspconfig plugin. Server configs live in `lsp/<server>.lua` as plain tables with `cmd`, `filetypes`, `root_markers`, etc. Servers must be registered in `lua/fere/lsp.lua` via `vim.lsp.enable()`. Global LSP keymaps are set up in `lsp.lua` via an `LspAttach` autocmd.

**jdtls is the exception** -- Java uses `nvim-jdtls` plugin configured entirely in `ftplugin/java.lua` (not `lsp/`). The spec in `plugins/jdtls.lua` only declares the plugin dependency. `ftplugin/java.lua` handles: jdtls startup via `start_or_attach()`, DAP bundle loading (java-debug-adapter + java-test JARs from Mason), workspace directory detection, and Java-specific keymaps (`<leader>co`, `<leader>cv`, `<leader>cm`). It uses SDKMAN-managed JDKs: Java 25 runs jdtls itself, Java 17 is the default project runtime.

### Plugin System

Each file in `lua/fere/plugins/` returns a lazy.nvim spec table and is auto-discovered. To disable a plugin, move its file to `lua/fere/plugins.old/` (not loaded). Shared config modules go in `lua/fere/configurations/` and are `require()`d by plugin specs (e.g., `dashboard.lua` is used by `Snacks.lua`).

### DAP (Debugging)

Centralized in `plugins/nvim-dap.lua` with a filetype-based dispatcher:
- `<leader>daTr` (test nearest): Python routes to `dap-python.test_method()`, Java routes to `jdtls.test_nearest_method()`
- `<leader>daTc` (test class): Java only, routes to `jdtls.test_class()`
- `<leader>daJ`: Java main class discovery + debug

### Formatting

`conform.nvim` (`plugins/conform.lua`) handles all formatting with a `BufWritePre` autocmd for format-on-save. Formatters are configured per-filetype in `formatters_by_ft`.

## How To Add Things

### New Plugin
Create `lua/fere/plugins/<name>.lua` returning a lazy.nvim spec. No imports needed.

### New LSP Server
1. Create `lsp/<server>.lua` returning `{ cmd, filetypes, root_markers, ... }`
2. Add server name to `vim.lsp.enable()` in `lua/fere/lsp.lua`

### New Formatter
Add entry to `formatters_by_ft` in `lua/fere/plugins/conform.lua`.

### Filetype-Specific Config
Create `ftplugin/<filetype>.lua` -- runs automatically on buffer open for that filetype.

## Key Conventions

- **Leader key**: Space
- **Transparent background**: Forced in `settings.lua` and `catpuccin.lua` highlight overrides
- **Completion**: nvim-cmp with `<C-y>` to confirm, `<C-j>`/`<C-k>` to navigate
- **Copilot**: suggestion mode with `<C-d>` to accept (not tab)
- **Keymaps**: Plugin-specific keymaps live inside each plugin's `config` function; global keymaps in `remap.lua`; LSP keymaps in `lsp.lua`
- **LSP prefix**: `<leader>d` (definition, implementation, rename, code action, diagnostics, format)
- **DAP prefix**: `<leader>da` (run, breakpoint, step, terminate, test)

## External Dependencies

- **Mason** (`:Mason`): Installs LSP servers, formatters, DAP adapters
- **SDKMAN**: Java SDKs at `~/.sdkman/candidates/java/`
- **Node.js**: Required for ts_ls, eslint, vue_ls, Copilot
- **ripgrep**: Required for Telescope live grep
