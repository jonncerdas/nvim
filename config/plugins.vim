call plug#begin('~/.config/nvim/plugged')

    Plug 'preservim/nerdtree'
    Plug 'projekt0n/github-nvim-theme'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'airblade/vim-gitgutter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'majutsushi/tagbar'
    Plug 'akinsho/bufferline.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    Plug 'github/copilot.vim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'on': ['CopilotChat', 'CopilotChatOpen', 'CopilotChatVisual', 'CopilotChatExplain', 'CopilotChatFix', 'CopilotChatTests'] }


call plug#end()
