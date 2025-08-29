return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      highlights = {
        buffer_selected = {
          bold = true,
        },
      },
      options = {
        mode = "buffer",
        close_command = "bdelete %d",
        right_mouse_command = "bdelete %d",
        diagnostics = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end
      }
    })
  end
}
