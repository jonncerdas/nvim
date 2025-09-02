" Nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Python
"
" " the ignore patterns are regular expression strings and seprated by comma
let NERDTreeIgnore = ['^node_modules$', '\.pyc$', '^__pycache__$']


let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeMapOpenInTab='\r'
let g:nerdtree_open=0

function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

" ctrlp
let g:ctrlp_user_commnand = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" BufferLine
" In your init.lua or init.vim
set termguicolors
lua << EOF
local ok, bufferline = pcall(require, 'bufferline')
if ok then
  bufferline.setup({
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = false,
      offsets = {
        { filetype = 'nerdtree', text = 'File Explorer', text_align = 'left', separator = true },
        { filetype = 'tagbar', text = 'Tags', text_align = 'left', separator = true },
      },
    },
  })
end
EOF

" Copilot
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_filetypes = {
\  '*': v:true,
\}

" CopilotChat minimal setup
lua << EOF
local ok, chat = pcall(require, 'CopilotChat')
if ok then
  chat.setup({ })
end
EOF
