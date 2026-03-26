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

" Terminal manager with multiple tabs
lua << EOF
local terminals = {}
local current_term = 1
local term_win = nil

local function get_term_label(index)
  local buf = terminals[index]
  if buf and vim.api.nvim_buf_is_valid(buf) then
    return string.format("[%d]", index)
  end
  return string.format(" %d ", index)
end

local function render_term_tabs()
  if not term_win or not vim.api.nvim_win_is_valid(term_win) then return end

  local tabs = ""
  local total = math.max(#terminals, current_term)

  for i = 1, total do
    if terminals[i] and vim.api.nvim_buf_is_valid(terminals[i]) then
      if i == current_term then
        tabs = tabs .. "%#TermTabActive# " .. i .. " %*"
      else
        tabs = tabs .. "%#TermTab# " .. i .. " %*"
      end
    end
  end

  local winbar = "  Terminal: " .. tabs .. "%=;tn: new  ;1-5: switch  ;Enter: hide "
  vim.api.nvim_win_set_option(term_win, 'winbar', winbar)
end

-- Set up highlight groups for terminal tabs
vim.api.nvim_set_hl(0, 'TermTab', { fg = '#888888', bg = '#1e1e1e' })
vim.api.nvim_set_hl(0, 'TermTabActive', { fg = '#1e1e1e', bg = '#7dcfff', bold = true })

function ToggleTerminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    -- Terminal is visible, hide it
    vim.api.nvim_win_hide(term_win)
    term_win = nil
    return
  end

  -- Show terminal
  vim.cmd('botright split')
  term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(term_win, 'number', false)
  vim.api.nvim_win_set_option(term_win, 'relativenumber', false)
  vim.api.nvim_win_set_option(term_win, 'signcolumn', 'no')

  local buf = terminals[current_term]
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_win_set_buf(term_win, buf)
  else
    vim.cmd('terminal')
    terminals[current_term] = vim.api.nvim_get_current_buf()
  end

  vim.cmd('resize 15')
  render_term_tabs()
  vim.cmd('startinsert')
end

function SwitchTerminal(index)
  current_term = index

  if not term_win or not vim.api.nvim_win_is_valid(term_win) then
    ToggleTerminal()
    return
  end

  local buf = terminals[current_term]
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_win_set_buf(term_win, buf)
  else
    vim.cmd('terminal')
    terminals[current_term] = vim.api.nvim_get_current_buf()
  end

  render_term_tabs()
  vim.cmd('startinsert')
end

function NextTerminal()
  local next = current_term + 1
  if next > #terminals then next = 1 end
  if next < 1 then next = 1 end
  SwitchTerminal(next)
end

function PrevTerminal()
  local prev = current_term - 1
  if prev < 1 then prev = math.max(#terminals, 1) end
  SwitchTerminal(prev)
end

function NewTerminal()
  current_term = #terminals + 1
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.cmd('terminal')
    terminals[current_term] = vim.api.nvim_get_current_buf()
    render_term_tabs()
    vim.cmd('startinsert')
  else
    ToggleTerminal()
  end
end
EOF

" Toggle terminal
nnoremap <leader><CR> :lua ToggleTerminal()<CR>
tnoremap <leader><CR> <C-\><C-n>:lua ToggleTerminal()<CR>

" Switch terminal tabs with ;1, ;2, ;3, etc.
nnoremap <leader>1 :lua SwitchTerminal(1)<CR>
nnoremap <leader>2 :lua SwitchTerminal(2)<CR>
nnoremap <leader>3 :lua SwitchTerminal(3)<CR>
nnoremap <leader>4 :lua SwitchTerminal(4)<CR>
nnoremap <leader>5 :lua SwitchTerminal(5)<CR>
tnoremap <leader>1 <C-\><C-n>:lua SwitchTerminal(1)<CR>
tnoremap <leader>2 <C-\><C-n>:lua SwitchTerminal(2)<CR>
tnoremap <leader>3 <C-\><C-n>:lua SwitchTerminal(3)<CR>
tnoremap <leader>4 <C-\><C-n>:lua SwitchTerminal(4)<CR>
tnoremap <leader>5 <C-\><C-n>:lua SwitchTerminal(5)<CR>

" New terminal
nnoremap <leader>tn :lua NewTerminal()<CR>
tnoremap <leader>tn <C-\><C-n>:lua NewTerminal()<CR>

" Cycle terminals with Ctrl+Tab (in terminal mode)
tnoremap <C-Tab> <C-\><C-n>:lua NextTerminal()<CR>
tnoremap <C-S-Tab> <C-\><C-n>:lua PrevTerminal()<CR>

" Exit terminal mode with Esc or jj
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>

" Navigate from terminal mode directly
tnoremap <leader><Up> <C-\><C-n>:wincmd k<CR>
tnoremap <leader><Down> <C-\><C-n>:wincmd j<CR>
tnoremap <leader><Left> <C-\><C-n>:wincmd h<CR>
tnoremap <leader><Right> <C-\><C-n>:wincmd l<CR>

" Auto-enter terminal mode when switching to terminal buffer
autocmd BufEnter term://* startinsert
autocmd WinEnter term://* startinsert

" Resize splits with Ctrl + arrow keys
nnoremap <C-Up> :resize +3<CR>
nnoremap <C-Down> :resize -3<CR>
nnoremap <C-Left> :vertical resize -3<CR>
nnoremap <C-Right> :vertical resize +3<CR>

" Also work from terminal mode
tnoremap <C-Up> <C-\><C-n>:resize +3<CR>i
tnoremap <C-Down> <C-\><C-n>:resize -3<CR>i
tnoremap <C-Left> <C-\><C-n>:vertical resize -3<CR>i
tnoremap <C-Right> <C-\><C-n>:vertical resize +3<CR>i

" Cheatsheet
nnoremap <leader>? :Cheatsheet<CR>
