local WorkDir = {
  condition = function(self)
    local root = LazyVim.root.get({ normalize = true })
    self.root = vim.fs.basename(root)
    return self.root ~= nil
  end,
  update = { "BufEnter" },
  {
    provider = function(self)
      return "󱉭 " .. self.root
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
      return enc
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
      return self.symbols[fmt] or fmt
    end,
  },
}

return {
  "rebelot/heirline.nvim",
  dependencies = {
    "Zeioth/heirline-components.nvim",
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
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        WorkDir,
        lib.component.git_branch(),
        lib.component.file_info(),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        FileFormat,
        FileEncoding,
        lib.component.nav({ scrollbar = false }),
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
