local WorkDir = {
  static = {
    root_patterns = { ".git", "lua" },
  },
  condition = function(self)
    self.root = require('mini.misc').find_root(0, self.root_patterns)
    return self.root ~= nil
  end,
  update = { "BufEnter" },
  {
    provider = function(self)
      return "󱉭 " .. vim.fn.fnamemodify(vim.fs.normalize(self.root), ":t")
    end,
  },
  {
    provider = "   ",
  },
}

local FileEncoding = {
  {
    provider = " ",
  },
  {
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
      return enc:upper()
    end,
  },
}

local FileFormat = {
  static = {
    symbols = {
      unix = " LF",
      dos = " CRLF",
      mac = " LF",
    },
  },
  {
    provider = "   ",
  },
  {
    provider = function(self)
      local fmt = vim.bo.fileformat
      return self.symbols[fmt] or fmt:upper()
    end,
  },
}

return {
  "rebelot/heirline.nvim",
  dependencies = {
    "Zeioth/heirline-components.nvim",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.misc",
  },
  opts = function()
    local lib = require("heirline-components.all")
    return {
      tabline = {
        lib.component.tabline_conditional_padding(),
        lib.component.tabline_buffers(),
        lib.component.fill({ hl = { bg = "tabline_bg" } }),
        lib.component.tabline_tabpages(),
      },
      statuscolumn = {
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        lib.component.foldcolumn({ condition=function() return true end, }),
        lib.component.numbercolumn(),
        lib.component.signcolumn({ condition=function() return true end, }),
      } or nil,
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        WorkDir,
        lib.component.git_branch({ hl = { fg = "#abb2bf" } }),
        lib.component.file_info(),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        FileFormat,
        FileEncoding,
        lib.component.nav({ scrollbar = false, }),
        lib.component.mode({ surround = { separator = "right" } }),
      },
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local heirline_components = require("heirline-components.all")
    heirline_components.init.subscribe_to_events()
    heirline.load_colors(heirline_components.hl.get_colors())
    heirline.setup(opts)
  end,
}
