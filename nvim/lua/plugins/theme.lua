return {
  -- Configure the default theme (tokyonight) to be transparent
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent", -- make the file tree transparent
        floats = "transparent", -- make floating windows transparent
      },
    },
  },
}
