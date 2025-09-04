local color = {
  -- none = 'NONE',
  -- -- bg0 = '#282c34',
  -- bg0 = '#1E1E1E',
  -- -- bg1 = '#21252b',
  -- bg1 = '#1E1E1E',
  -- bg_highlight = '#000000',
  -- bg_visual = '#393f4a',
  -- black0 = '#20232A',
  -- blue0 = '#61afef',
  -- blue1 = '#528bff',
  -- cyan0 = '#56b6c2',
  -- -- cyan0 = '#ff0000',
  -- fg0 = '#abb2bf',
  -- fg_dark = '#798294',
  -- fg_gutter = '#5c6370',
  -- fg_light = '#adbac7',
  -- green0 = '#98c379',
  -- orange0 = '#e59b4e',
  -- orange1 = '#d19a66',
  -- purple0 = '#c678dd',
  -- red0 = '#e06c75',
  -- red1 = '#e86671',
  -- red2 = '#f65866',
  -- yellow0 = '#ebd09c',
  -- yellow1 = '#e5c07b',
  -- dev_icons = {
  --   blue = '#519aba',
  --   green0 = '#8dc149',
  --   yellow = '#cbcb41',
  --   orange = '#e37933',
  --   red = '#cc3e44',
  --   purple = '#a074c4',
  --   pink = '#f55385',
  --   gray = '#4d5a5e',
  -- },
  -- m_yellow0 = '#FFD700',
  -- m_yellow1 = '#BDB76B',
  -- m_orange0 = '#FF8000',
  -- m_white0 = '#BFBFB4',
  -- m_purple0 = '#8F5DAF',
  -- m_purple1 = '#D8A0DF',
  -- m_blue0 = '#00E2C8',
  -- m_green0 = '#57A64A',
  -- m_red0 = '#D69D85',
  yellow0 = '#FFD700', -- class
  black0 = '#1E1E1E',
  orange0 = '#FF5900',
  orange1 = '#FF8000',
  purple0 = '#D8A0DF',
  purple1 = '#BD63C5',
  brown0 = '#D69D85',
  white0 = '#BFBFB4',
  white1 = '#CDD6F4',
  blue0 = '#3084B4',
  blue1 = '#00E2C8',
}



return {
  "catppuccin/nvim",
  config = function()
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    require("catppuccin").setup({
      dim_inactive = {
        enabled = false,   -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      color_overrides = {
        all = {
          base = color.black0
        }
      },
      highlight_overrides = {
        all = function(colors)
          return {
            ['Type'] = { fg = color.yellow0 },
            ['Keyword'] = { fg = color.orange0, bold = true },
            ['Function'] = { fg = color.orange1 },
            ['Method'] = { fg = color.orange1, italic = true },
            ['Structure'] = { fg = color.yellow0, bold = true },
            ['Namespace'] = { fg = color.yellow0, bold = true, underline = true },
            ['Exception'] = { fg = color.purple0, bold = true },
            ['Conditional'] = { fg = color.purple0 },
            ['Macro'] = { fg = color.purple1, bold = true },
            ['Operator'] = { fg = color.purple0 },
            ['Enum'] = { fg = color.blue0, bold = true },
            ['EnumMember'] = { fg = color.blue1, bold = true },
            -- ['String'] = { fg = color.brown0 },
            ['Number'] = { fg = color.brown0 },
            ['Variable'] = { fg = color.white0 },
            ['ParameterVariable'] = { fg = color.brown0 },
            ['Property'] = { fg = color.brown0, italic = true },
            ['ConstVariable'] = { fg = color.brown0 },
            ['ConstProperty'] = { fg = color.brown0, italic = true, underline = true },
            ['WinSeparator'] = { link = 'FloatBorder' },
            ['ToggleTerm1FloatBorder'] = { link = 'FloatBorder' },
            -- ['StaticVariable'] = { fg = color.white0 },
            -- ['StaticProperty'] = { fg = color.white0 },

            ['@type.builtin.cpp'] = { fg = color.yellow0 },
            ['@Keyword.return'] = { link = 'Keyword' },
            ['@keyword.import.cpp'] = { fg = color.purple0 },
            ['@module'] = { link = 'Namespace' },
            ['@property'] = { link = 'Property' },

            ['@variable.parameter'] = { link = 'ParameterVariable' },

            ['@lsp.type.class.cpp'] = { link = 'Structure' },
            ['@lsp.type.namespace.cpp'] = { link = 'Namespace' },
            ['@lsp.type.method.cpp'] = { link = 'Method' },
            ['@lsp.mod.readonly.cpp'] = { bold = true },
            ['@lsp.mod.static.cpp'] = { underline = true },
            ['@lsp.mod.fileScope.cpp'] = { underline = true },
            ['@lsp.type.enumMember'] = { link = 'EnumMember' },
            ['@lsp.type.enum.cpp'] = { link = 'Enum' },
          }
        end
      }
    })
  end
}
