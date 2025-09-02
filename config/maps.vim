let mapleader=";"

" move through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bp<bar>bd#<CR>

" copy, cut and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" duplicate line
nmap <leader>d :t.<CR>

" ctrlP
let g:ctrlp_map = '<C-p>'

" TagbarToggle
map <leader>t :TagbarToggle<CR>

inoremap jj <Esc>

" CopilotChat
nnoremap <silent> <leader>cc :lua CopilotChatOpenTolerant()<CR>
nnoremap <leader>ce :CopilotChatExplain<CR>
nnoremap <leader>cf :CopilotChatFix<CR>
nnoremap <leader>ct :CopilotChatTests<CR>

" Cheatsheet
nnoremap <leader>? :Cheatsheet<CR>
