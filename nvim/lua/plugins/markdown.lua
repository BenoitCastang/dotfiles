return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- Enable everything nicely
      heading = {
        enabled = true,
        sign = true, -- or false if you prefer no sign column icons
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " }, -- nice nerd font icons
        position = "overlay", -- or "inline" / "right"
        width = "full",
        left_pad = 0,
        right_pad = 0,
        backgrounds = { -- you can customize colors if you want
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          -- etc.
        },
      },

      table = {
        enabled = true,
        -- style = "full",     -- try "none" or "normal" if tables look weird
      },

      checkbox = {
        enabled = true,
        -- Custom icons (requires a good nerd font)
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
        -- You can add more states if you use custom checkboxes
      },

      -- Other nice defaults
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },

      -- If you want render-markdown to also work in insert mode or other modes
      render_modes = { "n", "c", "t" }, -- default is usually only normal
    },
  },
}
