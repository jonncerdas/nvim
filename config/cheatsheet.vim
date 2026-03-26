" Tabbed Cheatsheet with live search across all tabs
lua << EOF
local api = vim.api

-- All keybindings organized by category
local categories = {
  {
    name = "All",
    keys = {}, -- Will be populated dynamically
  },
  {
    name = "Custom",
    keys = {
      { key = ";↑ ;↓ ;← ;→", desc = "Move between splits" },
      { key = ";[  ;]", desc = "Previous / Next buffer" },
      { key = ";x", desc = "Close current buffer" },
      { key = ";d", desc = "Duplicate current line" },
      { key = "jj", desc = "Exit insert mode" },
      { key = ";n", desc = "Toggle NERDTree" },
      { key = ";t", desc = "Toggle Tagbar" },
      { key = ";Enter", desc = "Toggle terminal (hide/show)" },
      { key = ";?", desc = "Open this cheatsheet" },
    },
  },
  {
    name = "LSP",
    keys = {
      { key = "gd", desc = "Go to definition" },
      { key = "gy", desc = "Go to type definition" },
      { key = "gi", desc = "Go to implementation" },
      { key = "gr", desc = "Find references" },
      { key = "K", desc = "Show documentation/hover" },
      { key = ";rn", desc = "Rename symbol" },
      { key = ";fm", desc = "Format code/selection" },
      { key = ";ca", desc = "Code actions" },
      { key = ";cf", desc = "Quick fix" },
      { key = "[d  ]d", desc = "Previous / Next diagnostic" },
      { key = ";cd", desc = "List all diagnostics" },
      { key = ";oi", desc = "Organize imports" },
      { key = "Tab / S-Tab", desc = "Navigate completion" },
      { key = "Enter", desc = "Confirm completion" },
      { key = "Ctrl+Space", desc = "Trigger completion" },
    },
  },
  {
    name = "Search",
    keys = {
      { key = "Ctrl+p  ;ff", desc = "Find files" },
      { key = ";fg", desc = "Live grep (search in files)" },
      { key = ";fb", desc = "Find buffers" },
      { key = ";fh", desc = "Search help" },
      { key = "/pattern", desc = "Search forward" },
      { key = "?pattern", desc = "Search backward" },
      { key = "n  N", desc = "Next / Previous match" },
      { key = "*  #", desc = "Search word under cursor" },
      { key = ":noh", desc = "Clear search highlight" },
      { key = ":%s/old/new/g", desc = "Replace all in file" },
      { key = ":%s/old/new/gc", desc = "Replace with confirm" },
      { key = "f<c>  F<c>", desc = "Find char in line fwd/back" },
    },
  },
  {
    name = "Move",
    keys = {
      { key = "h j k l", desc = "Left / Down / Up / Right" },
      { key = "w  b  e", desc = "Word start / Prev word / End" },
      { key = "0  $", desc = "Start / End of line" },
      { key = "^", desc = "First non-blank character" },
      { key = "gg  G", desc = "First / Last line" },
      { key = "5G  :5", desc = "Go to line 5" },
      { key = "{  }", desc = "Previous / Next paragraph" },
      { key = "%", desc = "Jump to matching bracket" },
      { key = "Ctrl+d  Ctrl+u", desc = "Half page down / up" },
      { key = "Ctrl+f  Ctrl+b", desc = "Full page down / up" },
      { key = "zz  zt  zb", desc = "Center / Top / Bottom" },
    },
  },
  {
    name = "Select",
    keys = {
      { key = "v", desc = "Visual mode (char)" },
      { key = "V", desc = "Visual line mode" },
      { key = "Ctrl+v", desc = "Visual block mode (columns)" },
      { key = "viw  vaw", desc = "Select inner/around word" },
      { key = "vi\"  va\"", desc = "Select inner/around quotes" },
      { key = "vi(  vi{  vi[", desc = "Select inside brackets" },
      { key = "vit  vat", desc = "Select inner/around tag" },
      { key = "vip  vap", desc = "Select inner/around paragraph" },
      { key = "ggVG", desc = "Select entire file" },
      { key = "gv", desc = "Reselect last selection" },
      { key = "o", desc = "Move to other end of selection" },
    },
  },
  {
    name = "Edit",
    keys = {
      { key = "y  yy", desc = "Yank selection / line" },
      { key = "d  dd", desc = "Delete selection / line" },
      { key = "c  cc", desc = "Change selection / line" },
      { key = "p  P", desc = "Paste after / before" },
      { key = "x", desc = "Delete character" },
      { key = "r<c>", desc = "Replace single character" },
      { key = "ciw diw yiw", desc = "Change/delete/yank word" },
      { key = "ci\" di\" yi\"", desc = "Change/delete/yank in quotes" },
      { key = "Ctrl+c Ctrl+x", desc = "Copy/cut to system clipboard" },
      { key = "u  Ctrl+r", desc = "Undo / Redo" },
      { key = ".", desc = "Repeat last command" },
      { key = ">>  <<", desc = "Indent / Unindent line" },
      { key = "J", desc = "Join line below" },
      { key = "~  gu  gU", desc = "Toggle / Lower / Upper case" },
    },
  },
  {
    name = "Multi",
    keys = {
      { key = "Ctrl+v jjI<txt>Esc", desc = "Insert on multiple lines" },
      { key = "Ctrl+v jjA<txt>Esc", desc = "Append on multiple lines" },
      { key = "Ctrl+v jjc<txt>Esc", desc = "Change on multiple lines" },
      { key = "Ctrl+v jjd", desc = "Delete column" },
      { key = "Vjj>", desc = "Indent selected lines" },
      { key = "Vjj<", desc = "Unindent selected lines" },
      { key = ">5j  <5j", desc = "Indent/unindent 5 lines down" },
      { key = ">ip  <ip", desc = "Indent/unindent paragraph" },
      { key = "=ip", desc = "Auto-indent paragraph" },
      { key = ":5,10d", desc = "Delete lines 5-10" },
      { key = ":5,10y", desc = "Yank lines 5-10" },
      { key = ":5,10s/a/b/g", desc = "Replace in lines 5-10" },
    },
  },
  {
    name = "Comment",
    keys = {
      { key = "gcc", desc = "Toggle line comment" },
      { key = "gc", desc = "Comment selection (visual)" },
      { key = "gbc", desc = "Toggle block comment" },
      { key = "gcO  gco", desc = "Add comment above / below" },
      { key = "gcA", desc = "Add comment at end of line" },
      { key = "ys<m><c>", desc = "Add surround (e.g. ysiw\")" },
      { key = "yss<c>", desc = "Surround entire line" },
      { key = "cs<old><new>", desc = "Change surround (cs\"')" },
      { key = "ds<c>", desc = "Delete surround (ds\")" },
      { key = "S<c>", desc = "Surround selection (visual)" },
    },
  },
  {
    name = "Git",
    keys = {
      { key = ";gs", desc = "Git status (fugitive)" },
      { key = ";ga", desc = "Git add current file" },
      { key = ";gc", desc = "Git commit" },
      { key = ";gp", desc = "Git push" },
      { key = ";gl", desc = "Git pull" },
      { key = ";gd", desc = "Git diff split" },
      { key = ";gb", desc = "Git blame" },
      { key = ";gL", desc = "Git log" },
      { key = ";gr", desc = "Git rebase interactive" },
      { key = ";gS", desc = "Git stash" },
      { key = ";gSp", desc = "Git stash pop" },
      { key = ";gSl", desc = "Git stash list" },
      { key = ";gcp", desc = "Git cherry-pick (enter hash)" },
      { key = "[c  ]c", desc = "Prev/next hunk (gitgutter)" },
      { key = ";hp", desc = "Preview hunk" },
      { key = ";hs", desc = "Stage hunk" },
      { key = ";hu", desc = "Undo hunk" },
    },
  },
  {
    name = "Files",
    keys = {
      { key = ":w", desc = "Save file" },
      { key = ":q  :q!", desc = "Quit / Force quit" },
      { key = ":wq  :x  ZZ", desc = "Save and quit" },
      { key = ":e <file>", desc = "Open file" },
      { key = ":bn  :bp", desc = "Next / Previous buffer" },
      { key = ":bd", desc = "Close buffer" },
      { key = ":ls", desc = "List buffers" },
      { key = ":sp  :vsp", desc = "Horizontal / Vertical split" },
      { key = "Ctrl+w w", desc = "Switch windows" },
      { key = "Ctrl+w hjkl", desc = "Navigate windows" },
      { key = "Ctrl+w q", desc = "Close window" },
    },
  },
  {
    name = "Marks",
    keys = {
      { key = "ma", desc = "Set mark 'a'" },
      { key = "'a  `a", desc = "Jump to mark (line/exact)" },
      { key = "''", desc = "Jump to last position" },
      { key = "Ctrl+o  Ctrl+i", desc = "Jump back / forward" },
      { key = ":marks", desc = "List marks" },
      { key = "qa", desc = "Record macro 'a'" },
      { key = "q", desc = "Stop recording" },
      { key = "@a  @@", desc = "Play macro / Replay last" },
      { key = "5@a", desc = "Play macro 5 times" },
    },
  },
  {
    name = "Insert",
    keys = {
      { key = "i  a", desc = "Insert before / after cursor" },
      { key = "I  A", desc = "Insert at line start / end" },
      { key = "o  O", desc = "New line below / above" },
      { key = "ea", desc = "Insert at end of word" },
      { key = "Esc  jj", desc = "Exit insert mode" },
      { key = "Ctrl+w", desc = "Delete word before cursor" },
      { key = "Ctrl+u", desc = "Delete to start of line" },
      { key = ";Enter", desc = "Toggle terminal (hide/show)" },
      { key = ";1 ;2 ;3 ...", desc = "Switch to terminal 1, 2, 3..." },
      { key = ";tn", desc = "New terminal tab" },
      { key = "Ctrl+Tab", desc = "Next terminal tab" },
      { key = "Esc or jj", desc = "Exit terminal mode" },
      { key = ";↑ ;↓ ;← ;→", desc = "Navigate away from terminal" },
      { key = ";=  ;-", desc = "Resize height (taller/shorter)" },
      { key = ";.  ;,", desc = "Resize width (wider/narrower)" },
    },
  },
}

-- Highlight groups
local function setup_highlights()
  api.nvim_set_hl(0, 'CheatTab', { fg = '#666666', bg = 'NONE' })
  api.nvim_set_hl(0, 'CheatTabActive', { fg = '#7dcfff', bg = 'NONE', bold = true, underline = true })
  api.nvim_set_hl(0, 'CheatKey', { fg = '#7dcfff', bold = true })
  api.nvim_set_hl(0, 'CheatDesc', { fg = '#c0caf5' })
  api.nvim_set_hl(0, 'CheatCat', { fg = '#bb9af7' })
  api.nvim_set_hl(0, 'CheatBorder', { fg = '#444444' })
  api.nvim_set_hl(0, 'CheatHelp', { fg = '#666666', italic = true })
  api.nvim_set_hl(0, 'CheatSearch', { fg = '#c0caf5' })
  api.nvim_set_hl(0, 'CheatPrompt', { fg = '#7aa2f7', bold = true })
end

local buf, win
local current_tab = 1
local search_query = ""

local function get_keys_for_tab(tab_index)
  if tab_index == 1 then
    -- "All" tab - combine all categories
    local results = {}
    for i = 2, #categories do
      for _, kb in ipairs(categories[i].keys) do
        table.insert(results, { key = kb.key, desc = kb.desc, cat = categories[i].name })
      end
    end
    return results
  else
    local cat = categories[tab_index]
    local results = {}
    for _, kb in ipairs(cat.keys) do
      table.insert(results, { key = kb.key, desc = kb.desc, cat = cat.name })
    end
    return results
  end
end

local function get_filtered_keys()
  -- When searching, always search ALL tabs
  -- When not searching, show current tab only
  if search_query == "" then
    return get_keys_for_tab(current_tab)
  end

  -- Global search across all tabs
  local all_keys = get_keys_for_tab(1) -- "All" tab has everything
  local results = {}
  local query = search_query:lower()

  for _, kb in ipairs(all_keys) do
    if kb.key:lower():find(query, 1, true) or
       kb.desc:lower():find(query, 1, true) or
       kb.cat:lower():find(query, 1, true) then
      table.insert(results, kb)
    end
  end

  return results, true -- true = is global search
end

local function render()
  if not buf or not api.nvim_buf_is_valid(buf) then return end

  api.nvim_buf_set_option(buf, 'modifiable', true)

  local lines = {}
  local highlights = {}
  local width = 84

  -- Tab bar
  local tab_line = ""
  local col = 0
  for i, cat in ipairs(categories) do
    local name = " " .. cat.name .. " "
    if i == current_tab then
      table.insert(highlights, { 'CheatTabActive', 0, col, col + #name })
    else
      table.insert(highlights, { 'CheatTab', 0, col, col + #name })
    end
    tab_line = tab_line .. name
    col = col + #name
  end
  table.insert(lines, tab_line)

  -- Separator
  table.insert(lines, string.rep("─", width))
  table.insert(highlights, { 'CheatBorder', 1, 0, width })

  -- Search prompt
  local prompt_label = #search_query > 0 and "  > (all) " or "  > "
  local prompt_line = prompt_label .. search_query .. "│"
  table.insert(lines, prompt_line)
  table.insert(highlights, { 'CheatPrompt', 2, 0, #prompt_label })
  if #search_query > 0 then
    table.insert(highlights, { 'CheatSearch', 2, #prompt_label, #prompt_line - 1 })
  end

  -- Separator
  table.insert(lines, string.rep("─", width))
  table.insert(highlights, { 'CheatBorder', 3, 0, width })

  -- Add filtered keybindings
  local filtered, is_global = get_filtered_keys()
  local max_results = 12
  local show_category = (current_tab == 1) or is_global

  if #filtered == 0 then
    table.insert(lines, "")
    table.insert(lines, "  No matches found")
    table.insert(highlights, { 'CheatHelp', #lines - 1, 0, 20 })
  else
    local shown = math.min(#filtered, max_results)
    for i = 1, shown do
      local kb = filtered[i]
      local line
      if show_category then
        -- Show category when in "All" tab or when searching
        line = string.format("  %-22s  %-32s  %s", kb.key, kb.desc, kb.cat)
      else
        line = string.format("  %-22s  %s", kb.key, kb.desc)
      end
      table.insert(lines, line)
      local line_idx = #lines - 1
      table.insert(highlights, { 'CheatKey', line_idx, 2, 24 })
      table.insert(highlights, { 'CheatDesc', line_idx, 26, 58 })
      if show_category then
        table.insert(highlights, { 'CheatCat', line_idx, 60, 80 })
      end
    end

    if #filtered > max_results then
      table.insert(lines, string.format("  ... and %d more results", #filtered - max_results))
      table.insert(highlights, { 'CheatHelp', #lines - 1, 0, 40 })
    end
  end

  -- Add padding to fill window
  while #lines < 18 do
    table.insert(lines, "")
  end

  -- Footer
  table.insert(lines, string.rep("─", width))
  table.insert(highlights, { 'CheatBorder', #lines - 1, 0, width })

  local result_count = #filtered
  local help_text
  if #search_query > 0 then
    help_text = string.format("  %d results (global)    Backspace: delete    Esc: close", result_count)
  else
    help_text = string.format("  %d items    Tab/S-Tab: tabs    Type: search all    Esc: close", result_count)
  end
  table.insert(lines, help_text)
  table.insert(highlights, { 'CheatHelp', #lines - 1, 0, width })

  api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Apply highlights
  for _, hl in ipairs(highlights) do
    api.nvim_buf_add_highlight(buf, -1, hl[1], hl[2], hl[3], hl[4])
  end

  api.nvim_buf_set_option(buf, 'modifiable', false)
end

local function next_tab()
  current_tab = current_tab % #categories + 1
  render()
end

local function prev_tab()
  current_tab = (current_tab - 2) % #categories + 1
  render()
end

local function handle_backspace()
  if #search_query > 0 then
    search_query = search_query:sub(1, -2)
    render()
  end
end

local function close_cheatsheet()
  if win and api.nvim_win_is_valid(win) then
    api.nvim_win_close(win, true)
  end
end

local function open_cheatsheet()
  setup_highlights()
  current_tab = 1
  search_query = ""

  -- Calculate window size
  local width = 86
  local height = 21
  local ui = api.nvim_list_uis()[1]
  local col = math.floor((ui.width - width) / 2)
  local row = math.floor((ui.height - height) / 2)

  -- Create buffer
  buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(buf, 'filetype', 'cheatsheet')

  -- Create window
  win = api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
    title = ' Keybindings Cheatsheet ',
    title_pos = 'center',
  })

  -- Keymaps
  local opts = { noremap = true, silent = true, buffer = buf }

  -- Navigation
  vim.keymap.set('n', '<Tab>', next_tab, opts)
  vim.keymap.set('n', '<S-Tab>', prev_tab, opts)
  vim.keymap.set('n', '<C-l>', next_tab, opts)
  vim.keymap.set('n', '<C-h>', prev_tab, opts)

  -- Close
  vim.keymap.set('n', '<Esc>', close_cheatsheet, opts)
  vim.keymap.set('n', '<C-c>', close_cheatsheet, opts)

  -- Backspace
  vim.keymap.set('n', '<BS>', handle_backspace, opts)

  -- Capture all printable characters for search
  for i = 32, 126 do
    local char = string.char(i)
    vim.keymap.set('n', char, function()
      search_query = search_query .. char
      render()
    end, opts)
  end

  render()
end

vim.api.nvim_create_user_command('Keybindings', open_cheatsheet, {})
EOF

nnoremap <leader>? :Keybindings<CR>
