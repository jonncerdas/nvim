" In-editor cheatsheet
function! s:OpenCheatsheet() abort
  new
  setlocal buftype=nofile bufhidden=wipe noswapfile
  setlocal nobuflisted
  setlocal filetype=markdown
  setlocal modifiable
  call setline(1, [
        \ '# Neovim Cheatsheet',
        \ '',
        \ 'Leader: ;',
        \ '',
        \ 'Navigation',
        \ '  <leader><Up>/<Down>/<Left>/<Right>  Move between splits',
        \ '',
        \ 'Buffers',
        \ '  <leader>[   Previous buffer',
        \ '  <leader>]   Next buffer',
        \ '  <leader>x   Close current buffer',
        \ '',
        \ 'Clipboard',
        \ '  Visual Ctrl-c  Copy to system clipboard',
        \ '  Visual Ctrl-x  Cut to system clipboard',
        \ '  Visual Ctrl-v / Insert Ctrl-v  Paste from system clipboard',
        \ '',
        \ 'Editing',
        \ '  <leader>d   Duplicate current line',
        \ '  jj          Escape insert mode',
        \ '',
        \ 'Plugins',
        \ '  Ctrl-p       Open CtrlP',
        \ '  <leader>t    Toggle Tagbar',
        \ '  <leader>n    Toggle NERDTree',
        \ '',
        \ 'Copilot',
        \ '  <C-j>        Accept suggestion',
        \ '',
        \ 'CopilotChat',
        \ '  <leader>cc   Open chat',
        \ '  <leader>ce   Explain selection',
        \ '  <leader>cf   Fix selection',
        \ '  <leader>ct   Generate tests',
        \ '',
        \ 'Close this window: q',
        \ ])
  setlocal nomodifiable
  nnoremap <silent> <buffer> q :bd!<CR>
endfunction

command! Cheatsheet call s:OpenCheatsheet()
