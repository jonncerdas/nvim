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

" Telescope
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>

" TagbarToggle
map <leader>t :TagbarToggle<CR>

inoremap jj <Esc>

" Terminal (opens at bottom)
nnoremap <leader><CR> :botright split \| terminal<CR>
nnoremap <leader>` :botright split \| terminal<CR>

" Cheatsheet
nnoremap <leader>? :Cheatsheet<CR>
