return {
  -- keeping track of time
  {
    "wakatime/vim-wakatime",
  },

  -- copilot lua
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<tab>",
        },
      },
    },
  },
}
