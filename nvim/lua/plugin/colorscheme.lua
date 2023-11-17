return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 100,
    opts = {
      overrides = {
        GitSignsCurrentLineBlame = { link = "Comment" },
        ["@lsp.type.function.lua"] = { link = "GruvboxOrange" },
      },
      transparent_mode = true,
      contrast = "hard",
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
