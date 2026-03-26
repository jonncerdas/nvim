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
        enew
        NERDTree
        wincmd p
    end
endfunction
autocmd VimEnter * call StartUp()

" Telescope
lua << EOF
local ok, telescope = pcall(require, 'telescope')
if ok then
  telescope.setup({
    defaults = {
      file_ignore_patterns = { "node_modules", ".git" },
    },
  })
end
EOF

" Treesitter
lua << EOF
local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if ok then
  treesitter.setup({
    ensure_installed = {
      "javascript", "typescript", "tsx", "vue",
      "python", "json", "html", "css", "scss",
      "lua", "vim", "vimdoc", "bash", "markdown"
    },
    highlight = { enable = true },
    indent = { enable = true },
  })
end
EOF

" Autopairs
lua << EOF
local ok, autopairs = pcall(require, 'nvim-autopairs')
if ok then
  autopairs.setup({})
end
EOF

" Comment.nvim
lua << EOF
local ok, comment = pcall(require, 'Comment')
if ok then
  comment.setup({})
end
EOF

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
      always_show_bufferline = true,
      offsets = {
        { filetype = 'nerdtree', text = 'File Explorer', text_align = 'left', separator = true },
        { filetype = 'tagbar', text = 'Tags', text_align = 'left', separator = true },
      },
      custom_filter = function(buf_number)
        -- Hide terminal buffers from bufferline
        local buf_type = vim.bo[buf_number].buftype
        if buf_type == 'terminal' then
          return false
        end
        return true
      end,
    },
  })
end
EOF

" ============================================================================
" CoC (Conquer of Completion) Configuration
" ============================================================================

" Use Tab for trigger completion
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion with Ctrl+Space
inoremap <silent><expr> <C-Space> coc#refresh()

" Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Format code
nmap <leader>fm <Plug>(coc-format)
vmap <leader>fm <Plug>(coc-format-selected)

" Code actions
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>cf <Plug>(coc-fix-current)

" Diagnostics navigation
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Show all diagnostics
nnoremap <silent> <leader>cd :CocList diagnostics<CR>

" Organize imports
nmap <leader>oi :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" CoC extensions to install (auto-installs on startup)
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ '@yaegassy/coc-volar',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-emmet',
      \ ]
