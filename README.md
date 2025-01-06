# SwiftVim Configuration - A Beginner-Friendly Neovim Setup 🌟

Welcome to **SwiftVim** 🛠️, a Neovim configuration tailored for developers looking for an IDE-like experience with simplicity, speed, and powerful features. This README covers all the customizations, plugins, and settings implemented in this configuration.

---

## Features ✨

- Transparent background support. 🌈
- IDE-like features with LSP (Language Server Protocol). 🚀
- Block cursor in insert mode. 🔲
- Auto-save functionality. 💾
- Code completion for various languages. 🧠
- Syntax highlighting and themes. 🎨
- File explorer and search. 🔍
- Tabs with bufferline. 🗂️
- Remapped commands for improved productivity. ⌨️
- Support for Svelte, Django, and Machine Learning workflows. 🤖

---

## Installation Guide 📥

### Prerequisites 🛠️

1. **Neovim**: Install Neovim (version 0.8 or higher).
   ```bash
   sudo pacman -S neovim  # Arch Linux
   ```

2. **Node.js and npm**: Required for LSP and other plugins.
   ```bash
   sudo pacman -S nodejs npm
   ```

---

## Setup Instructions 🛠️

### 1. Clone the Configuration 🖥️

Clone this repository into your Neovim configuration directory:
```bash
git clone https://github.com/your-repo/swiftvim ~/.config/nvim
```

### 2. Install Plugins 📦

Launch Neovim and run:
```bash
:PackerSync
```
This will install all plugins defined in the `init.lua` file.

---

## Key Plugins Used 🔌

### Plugin Manager
- [Packer.nvim](https://github.com/wbthomason/packer.nvim): Manages all your plugins. 📦

### Core Plugins
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): LSP configuration for language support. 🌐
- [mason.nvim](https://github.com/williamboman/mason.nvim): Easily install and manage LSP servers. 🔧
- [cmp-nvim](https://github.com/hrsh7th/nvim-cmp): Autocompletion framework. ✍️
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder for files and text. 🔍
- [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua): File explorer. 🗂️
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim): Gruvbox theme with transparent background support. 🎨
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim): Tab-like interface for buffers. 🏷️

### Productivity Plugins
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs): Auto-closing of brackets and quotes. 🔒
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag): Auto-closing of HTML tags. 🌐
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git integration. 🐙

---

## Customizations and Keybindings 🔑

### 1. General Settings ⚙️
- **Tab Spaces**: Set to 4 spaces.
- **Relative Line Numbers**: Enabled for better navigation.
- **Transparent Background**: Supported for a modern look. 🌈

### 2. Keybindings ⌨️
| Action                | Keybinding           |
|-----------------------|----------------------|
| New File             | `Ctrl + N`          |
| Save File            | `Ctrl + S`          |
| Rename File          | `F2`                |
| Horizontal Split     | `Ctrl + H`          |
| Vertical Split       | `Ctrl + Shift + V`  |
| Cut                  | `Ctrl + X`          |
| Paste                | `Ctrl + V`          |
| Close Window         | `Ctrl + Shift + X`  |
| Open File Explorer   | `Ctrl + E`          |
| File Search          | `Ctrl + P`          |
| Text Search          | `Ctrl + F`          |

### 3. Additional Commands 📜
| Command               | Description                           |
|-----------------------|---------------------------------------|
| `:Mason`              | Open Mason for LSP management.       |
| `:Telescope find_files` | Search for files.                   |
| `:Telescope live_grep` | Search for text in files.            |
| `:NvimTreeToggle`     | Toggle file explorer.                |

---

## Language-Specific Configurations 🌍

### 1. JavaScript and Typescript Support 
- Integrated LSP support with `svelte-language-server`. 🔥

### 2. Django and Python Support 🐍
- Installed `pyright` for Python LSP.

---

## Themes 🎨
- Default: **Tokyo Night and Night Fox** with transparent background. 🌈
- Change themes by updating the `colorscheme` in the `init.lua` file.

---

## Troubleshooting 🛠️

1. **File Explorer Not Opening**:
   Ensure `nvim-tree` is installed and configured properly. Run `:PackerSync` if needed.

2. **Missing Language Servers**:
   Use Mason to install required LSP servers:
   ```bash
   :Mason
   ```

3. **Keybindings Not Working**:
   Ensure `init.lua` is properly sourced:
   ```bash
   :source %
   ```

---

Enjoy coding with **SwiftVim**! 🎉 If you encounter issues or have suggestions, feel free to contribute or raise an issue on GitHub. 🚀
