local palette = {
  none = "NONE",

  black = "black",
  background = "black",

  text = "#bcbcbc",
  muted = "#404040",
  upmuted = "#898989",
  dark = "#232323",
  toodark = "#121212",

  pink = "#cf89a9",

  red = "#bf6162",
  lowred = "#9f6162",

  yellow = "#f0b440",

  orange = "#f99440",
  loworange = "#e07430",

  purple = "#b090c0",

  green = "#70a080",
  upgreen = "#80a970",

  blue = "#8990c0",
  lowblue = "#50609f",

  cyan = "#70809f",
}
local p = palette

local function hi(name, config)
  vim.api.nvim_set_hl(0, name, config)
end

local groups = {
  Normal                     = { fg = p.text, bg = p.background },
  NormalNC                   = { fg = p.text, bg = p.background },

  IncSearch                  = { fg = p.background, bg = p.orange },
  Search                     = { fg = p.background, bg = p.lowred },
  CurSearch                  = { fg = p.background, bg = p.yellow },

  Comment                    = { fg = p.muted },

  Error                      = { fg = p.dark, bg = p.lowred, bold = true },
  ErrorMsg                   = { link = "Error" },
  DiagnosticError            = { fg = p.lowred, bg = p.background, bold = true },
  DiagnosticVirtualTextError = { link = "DiagnosticError" },
  DiagnosticFloatingError    = { link = "DiagnosticError" },

  WarningMsg                 = { fg = p.dark, bg = p.orange },
  DiagnosticWarn             = { fg = p.orange, bg = p.background },
  DiagnosticVirtualTextWarn  = { link = "DiagnosticWarn" },
  DiagnosticFloatingWarn     = { link = "DiagnosticWarn" },

  DiagnosticHint             = { fg = p.upmuted, bg = p.background },
  DiagnosticVirtualTextHint  = { link = "DiagnosticHint" },
  DiagnosticFloatingHint     = { link = "DiagnosticHint" },

  DiagnosticInfo             = { fg = p.muted, bg = p.background },
  DiagnosticVirtualTextInfo  = { link = "DiagnosticInfo" },
  DiagnosticFloatingInfo     = { link = "DiagnosticInfo" },

  DiagnosticOk               = { fg = p.green, bg = p.background },
  DiagnosticVirtualTextOk    = { link = "DiagnosticOk" },
  DiagnosticFloatingOk       = { link = "DiagnosticOk" },

  LineNr                     = { fg = p.dark },
  LineNrAbove                = { link = "LineNr" },
  LineNrBelow                = { link = "LineNr" },

  TabLine                    = { bg = p.background },
  TabLineFill                = { link = "TabLine" },

  CursorLine                 = { bg = p.toodark },
  CursorLineNr               = { fg = p.muted, bg = p.toodark },

  StatusLine                 = { fg = p.orange, bg = p.background, bold = true },
  SignColumn                 = { fg = p.dark, bg = p.background },
  FoldColumn                 = { link = "SignColumn" },
  CursorLineFold             = { link = "FoldColumn" },
  StatusLineNC               = { fg = p.muted, bg = p.background },

  Visual                     = { bg = p.dark },

  Identifier                 = { fg = p.purple },
  String                     = { fg = p.green },
  Character                  = { fg = p.upgreen },
  Function                   = { fg = p.blue },
  Todo                       = { fg = p.background, bg = p.loworange, bold = true },
  Constant                   = { fg = p.cyan },
  Float                      = { link = "Constant" },
  Boolean                    = { link = "Constant" },
  Statement                  = { fg = p.blue },

  Type                       = { fg = p.lowred },
  Special                    = { fg = p.lowred },

  PreProc                    = { fg = p.lowred },
  MatchParen                 = { bg = p.muted },
  Operator                   = { fg = p.upmuted },
  Delimiter                  = { fg = p.upmuted },
  Keyword                    = { fg = p.muted },

  Pmenu                      = { bg = p.toodark },
  PmenuSel                   = { bg = p.muted },

  NonText                    = { fg = p.muted },
  Whitespace                 = { link = "NonText" },

  ModeMsg                    = { fg = p.muted, bold = true },
}

groups["@variable"] = { link = "Identifier" }
groups["@property"] = { link = "Identifier" }

groups["@variable.member"] = { fg = p.pink }
groups["@lsp.type.property"] = { fg = p.pink }

groups["@variable.parameter"] = { fg = p.loworange }

groups["@number"] = { link = "Constant" }

groups["@module.rust"] = { fg = p.red }

groups["@keyword.directive"] = { link = "PreProc" }
groups["@keyword.import"] = { link = "PreProc" }

for name, config in pairs(groups) do
  hi(name, config)
end
