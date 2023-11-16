return {
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        ft_ignore = { "alpha", "neo-tree", "Trouble", "help" },
        bt_ignore = { "nofile" },
        segments = {
          {
            sign = {
              name = { "Diagnostic" },
              maxwidth = 1,
              colwidth = 2,
              auto = false,
              fillchar = " ",
            },
          },
          {
            text = {
              builtin.lnumfunc,
              " ",
            },
          },
          {
            sign = {
              namespace = { "gitsign*" },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
              wrap = true,
              fillchar = " ",
              fillcharhl = "StatusColumnSeparator",
            },
          },
        },
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = true,
  },
}
