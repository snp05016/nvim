# Neovim Configuration

This repository stores my Neovim configuration with all plugins. Clone and symlink to `~/.config/nvim/`.

## Features

- 🎨 **Tokyo Night** theme with transparency
- 🔍 **LSP Support** for C, C++, Python, Rust, Go, Java, TypeScript, Lua, Bash
- ✨ **Multi-cursor** editing with vim-visual-multi
- � **Clipboard history** with Yanky
- �📁 File explorer with NvimTree
- 🔭 Fuzzy finding with Telescope
- 💬 Autocompletion with nvim-cmp
- 🎯 Syntax highlighting with Treesitter

## Key Bindings

### General
- `Space` - Leader key
- `!` - Toggle NvimTree
- `<Esc>` - Clear search highlighting
- `<C-s>` - Save file (works in all modes)
- `<C-a>` - Select all

### Multi-cursor (vim-visual-multi)
- `<C-n>` - Select next occurrence of word
- `<C-Up>/<C-Down>` - Add cursor up/down
- `q` - Skip current, select next
- `Q` - Remove current cursor

### Clipboard
- `<Space>y` - Copy to system clipboard (normal & visual)
- `<Space>p` - Open yank/clipboard history (Telescope)
- `p` / `P` - Paste after/before cursor
- `<C-p>` - Cycle to previous yank in history (after paste)
- `<C-n>` - Cycle to next yank in history (after paste)

### Navigation
- `<S-h>` - Previous buffer
- `<S-l>` - Next buffer
- `<S-Tab>` - Switch window
- `<C-h/j/k/l>` - Navigate windows

### Window Management
- `<C-Up/Down>` - Resize window vertically
- `<C-Left/Right>` - Resize window horizontally

### LSP
- `gd` - Go to definition
- `gD` - Go to declaration
- `K` - Hover documentation
- `gi` - Go to implementation
- `gr` - Show references
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code action
- `<Space>f` - Format document
- `[d` / `]d` - Previous/next diagnostic
- `<Space>e` - Show diagnostic

### Telescope
- `<Space>ff` - Find files
- `<Space>fg` - Live grep
- `<Space>fb` - Browse buffers
- `<Space>fh` - Help tags
- `<Space>fo` - Old files
- `<Space>fd` - Diagnostics

### Line Movement
- `<A-Up>/<A-Down>` - Move line(s) up/down (normal & visual)

### Visual Mode
- `<` / `>` - Indent left/right (stays in visual mode)

### Terminal
- `<Space>tt` - Toggle terminal

### Buffer Management
- `<A-c>` - Close buffer
- `<A-p>` - Pin/unpin buffer
- `<A-,>/<A-.>` - Move buffer left/right

### Search & Replace
- `<Space>q` - Open Spectre (search/replace)
- `<Space>sw` - Search current word

## Installation

```bash
cd ~/.config
git clone <your-repo-url> nvimrepo
ln -s nvimrepo nvim
nvim
```

On first launch, run `:Lazy sync` to install all plugins.
