local WorkDir = {
  {
    provider = function()
      local cwd = LazyVim.root.cwd()
      local root = LazyVim.root.get({ normalize = true })
      local name = "󱉭 " .. vim.fs.basename(root)

      if root:find(cwd, 1, true) == 1 then
        return name
      elseif cwd:find(root, 1, true) == 1 then
        return name
      else
        return name
      end
    end,
  },
  {
    provider = " ",
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
    provider = "  ",
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
  dependencies = { "Zeioth/heirline-components.nvim" },
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
        lib.component.foldcolumn(),
        lib.component.numbercolumn(),
        lib.component.signcolumn(),
      } or nil,
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        WorkDir,
        lib.component.file_info(),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        FileFormat,
        FileEncoding,
        lib.component.nav(),
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
