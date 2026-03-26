call plug#begin('~/.config/nvim/plugged')

    " File explorer & UI
    Plug 'preservim/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim'
    Plug 'majutsushi/tagbar'

    " Themes
    Plug 'projekt0n/github-nvim-theme'
    Plug 'morhetz/gruvbox'

    " Search
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " LSP & Completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Editing helpers
    Plug 'windwp/nvim-autopairs'
    Plug 'numToStr/Comment.nvim'
    Plug 'tpope/vim-surround'

call plug#end()
