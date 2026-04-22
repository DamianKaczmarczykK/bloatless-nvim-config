# NeoVim config

My personal configuration for nvim:
- simple (less than 100 LOC, single `init.lua` file)
- fast (experience smooth as coconut butter)
- lsp (rename, format, goto definition, quickfix), fuzzy search (on files, words, diagnostics)

Additionally I provide very similar configuration for `IdeaVim` plugin in
`.ideavimrc` (very similar shortcuts).

There is nothing spectacular in this config, it may even lacks of some
functionality but after a few years I started to see that I don't need more.
It's a peaceful life.

> [!WARNING]
> To work correctly (find `vim` object) in `init.lua`, lua LSP would require 'folke/lazydev.nvim'
> plugin - TBH I don't need one

## Requirements
- nvim >= 0.12
- fzf
- installed LSPs, visible in PATH from `vim.lsp.enable({,,,})` list
    - e.g. `gopls` can be installed on Arch with `sudo pacman -S gopls`

If you need to have toolchain autoconfigured, see [Mason.nvim](https://github.com/mason-org/mason.nvim).

## Installation

### Nvim:

Copy `init.lua` to `~./config/nvim/init.lua`
```shell
mkdir -p ~/.config/nvim                 # init catalog if doesn't exist
cp init.lua ~/.config/nvim/init.lua     # copy config
```

### IdeaVim

```shell
rm ~/.ideavimrc                 # remove old config
ln -s .ideavimrc ~/.ideavimrc   # create symlink 

cp .ideavimrc ~/.ideavimrc      # or just copy directly
```
