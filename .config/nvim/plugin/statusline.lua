local api = vim.api

local set_hl = function(group, options)
  local bg = options.bg == nil and '' or 'guibg=' .. options.bg
  local fg = options.fg == nil and '' or 'guifg=' .. options.fg
  local gui = options.gui == nil and '' or 'gui=' .. options.gui

  vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
end

local highlights = {
  {'StatusLine', { fg = '#3C3836', bg = '#EBDBB2' }},
  {'StatusLineNC', { fg = '#3C3836', bg = '#928374' }},
  {'Mode', { bg = '#928374', fg = '#1D2021', gui="bold" }},
  {'LineCol', { bg = '#928374', fg = '#1D2021', gui="bold" }},
  {'Filetype', { bg = '#504945', fg = '#EBDBB2' }},
  {'Filename', { bg = '#504945', fg = '#EBDBB2' }},
  {'ModeAlt', { bg = '#504945', fg = '#928374' }},
  {'LineColAlt', { bg = '#504945', fg = '#928374' }},
  {'FiletypeAlt', { bg = '#3C3836', fg = '#504945' }},
}

for _, highlight in ipairs(highlights) do
  set_hl(highlight[1], highlight[2])
end

local M = {}

-- highlight groups
M.colors = {
  active        = '%#StatusLine#',
  inactive      = '%#StatuslineNC#',
  mode          = '%#Mode#',
  mode_alt      = '%#ModeAlt#',
  filetype      = '%#Filetype#',
  filetype_alt  = '%#FiletypeAlt#',
  line_col      = '%#LineCol#',
  line_col_alt  = '%#LineColAlt#',
}

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.modes = setmetatable({
  ['n']  = 'Normal';
  ['no'] = 'N·Pending';
  ['v']  = 'Visual';
  ['V']  = 'V·Line';
  [''] = 'V·Block'; -- this is not ^V, but it's , they're different
  ['s']  = 'Select';
  ['S']  = 'S·Line';
  [''] = 'S·Block'; -- same with this one, it's not ^S but it's 
  ['i']  = 'Insert';
  ['ic'] = 'Insert';
  ['R']  = 'Replace';
  ['Rv'] = 'V·Replace';
  ['c']  = 'Command';
  ['cv'] = 'Vim·Ex ';
  ['ce'] = 'Ex ';
  ['r']  = 'Prompt ';
  ['rm'] = 'More ';
  ['r?'] = 'Confirm ';
  ['!']  = 'Shell ';
  ['t']  = 'Terminal ';
}, {
  __index = function()
      return {'Unknown', 'U'} -- handle edge cases
  end
})

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode
  return string.format(' %s ', self.modes[current_mode]):upper()
end

M.get_filename = function(self)
  if self:is_truncated(140) then return " %<%f " end
  return " %<%F "
end

M.get_filetype = function()
  local filetype = vim.bo.filetype
  local fileformat = vim.bo.fileformat

  local readonly
  if vim.bo.readonly then
      readonly = '[read only]'
  else
      readonly = ''
  end

  if filetype == '' then return '' end
  return string.format(' %s %s [%s] ', filetype, readonly, fileformat):lower()
end

M.get_line_col = function(self)
  return ' Ln %l | Col %c '
end


M.set_active = function(self)
  local colors = self.colors

  local mode = colors.mode .. self:get_current_mode()
  local mode_alt = colors.active
  local filename = colors.inactive .. self:get_filename()
  local filetype_alt = colors.filetype_alt
  local filetype = colors.filetype .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()
  local line_col_alt = colors.line_col_alt

  return table.concat({
    colors.active, mode, mode_alt,
    "%=", filename, "%=",
    filetype_alt, filetype, line_col_alt, line_col
  })
end

M.set_inactive = function(self)
  return self.colors.inactive .. '%= %F %='
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
  end
})

-- set statusline
-- TODO: replace this once we can define autocmd using lua
api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  augroup END
]], false)
