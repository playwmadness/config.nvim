local palette = {
  none = "NONE",

  black = "black",
  background = "black",

  text = "#e0e0e0",
  muted = "#606060",
  upmuted = "#a0a0a0",
  dark = "#3c3c3c",
  toodark = "#1a1a1a",

  pink = "#f1a3b1",

  red = "#ff7f7f",
  lowred = "#c77f7f",

  yellow = "#ffcc66",

  orange = "#ffb366",
  loworange = "#ff8c30",

  purple = "#d1a3d0",

  green = "#8cc8a0",
  upgreen = "#a0c8a0",

  blue = "#a0b3e0",
  lowblue = "#6a8fd9",

  cyan = "#8cb3d9",
}
local p = palette

local function hi(name, config)
  vim.api.nvim_set_hl(0, name, config)
end

local groups = {
  Normal                      = { fg = p.text, bg = p.background },
  NormalNC                    = { fg = p.text, bg = p.background },

  IncSearch                   = { fg = p.background, bg = p.orange },
  Search                      = { fg = p.background, bg = p.lowred },
  CurSearch                   = { fg = p.background, bg = p.yellow },

  Comment                     = { fg = p.muted },

  Error                       = { fg = p.dark, bg = p.lowred, bold = true },
  ErrorMsg                    = { link = "Error" },
  DiagnosticError             = { fg = p.lowred, bg = p.background, bold = true },
  DiagnosticVirtualTextError  = { link = "DiagnosticError" },
  DiagnosticVirtualLinesError = { link = "DiagnosticError" },
  DiagnosticSignError         = { link = "DiagnosticError" },
  DiagnosticFloatingError     = { link = "DiagnosticError" },

  WarningMsg                  = { fg = p.dark, bg = p.orange },
  DiagnosticWarn              = { fg = p.orange, bg = p.background },
  DiagnosticVirtualTextWarn   = { link = "DiagnosticWarn" },
  DiagnosticSignWarn          = { link = "DiagnosticWarn" },
  DiagnosticVirtualLinesWarn  = { link = "DiagnosticWarn" },
  DiagnosticFloatingWarn      = { link = "DiagnosticWarn" },

  DiagnosticHint              = { fg = p.upmuted, bg = p.background },
  DiagnosticVirtualTextHint   = { link = "DiagnosticHint" },
  DiagnosticSignHint          = { link = "DiagnosticHint" },
  DiagnosticVirtualLinesHint  = { link = "DiagnosticHint" },
  DiagnosticFloatingHint      = { link = "DiagnosticHint" },

  DiagnosticInfo              = { fg = p.muted, bg = p.background },
  DiagnosticVirtualTextInfo   = { link = "DiagnosticInfo" },
  DiagnosticSignInfo          = { link = "DiagnosticInfo" },
  DiagnosticVirtualLinesInfo  = { link = "DiagnosticInfo" },
  DiagnosticFloatingInfo      = { link = "DiagnosticInfo" },

  DiagnosticOk                = { fg = p.green, bg = p.background },
  DiagnosticVirtualTextOk     = { link = "DiagnosticOk" },
  DiagnosticSignOk            = { link = "DiagnosticOk" },
  DiagnosticVirtualLinesOk    = { link = "DiagnosticOk" },
  DiagnosticFloatingOk        = { link = "DiagnosticOk" },

  LineNr                      = { fg = p.dark },
  LineNrAbove                 = { link = "LineNr" },
  LineNrBelow                 = { link = "LineNr" },

  TabLine                     = { bg = p.background },
  TabLineFill                 = { link = "TabLine" },

  CursorLine                  = { bg = p.toodark },
  CursorLineNr                = { fg = p.muted, bg = p.toodark },

  StatusLine                  = { fg = p.orange, bg = p.background, bold = true },
  SignColumn                  = { fg = p.dark, bg = p.background },
  FoldColumn                  = { link = "SignColumn" },
  CursorLineFold              = { link = "FoldColumn" },
  StatusLineNC                = { fg = p.muted, bg = p.background },

  Visual                      = { bg = p.dark },

  Identifier                  = { fg = p.purple },
  String                      = { fg = p.green },
  Character                   = { fg = p.upgreen },
  Function                    = { fg = p.blue },
  Todo                        = { fg = p.background, bg = p.loworange, bold = true },
  Constant                    = { fg = p.cyan },
  Float                       = { link = "Constant" },
  Boolean                     = { link = "Constant" },
  Statement                   = { fg = p.blue },

  Type                        = { fg = p.lowred },
  Special                     = { fg = p.lowred },

  PreProc                     = { fg = p.lowred },
  MatchParen                  = { bg = p.muted },
  Operator                    = { fg = p.upmuted },
  Delimiter                   = { fg = p.upmuted },
  Keyword                     = { fg = p.muted },

  Pmenu                       = { bg = p.toodark },
  PmenuSel                    = { bg = p.muted },

  NonText                     = { fg = p.muted },
  Whitespace                  = { link = "NonText" },

  ModeMsg                     = { fg = p.muted, bold = true },
}

groups["@variable"] = { link = "Identifier" }
groups["@property"] = { link = "Identifier" }

groups["@variable.member"] = { fg = p.pink }
groups["@lsp.type.property"] = { fg = p.pink }

groups["@variable.parameter"] = { fg = p.loworange }

groups["@number"] = { link = "Constant" }

groups["@module.rust"] = { fg = p.red }

groups["@lsp.type.namespace"] = { fg = p.purple }

groups["@keyword.directive"] = { link = "PreProc" }
groups["@keyword.import"] = { link = "PreProc" }

groups["@markup.heading.1"] = { fg = p.yellow, bold = true }
groups["@markup.heading.2"] = { fg = p.orange, bold = true }
groups["@markup.heading.3"] = { fg = p.red, bold = true }
groups["@markup.heading.4"] = { fg = p.purple }
groups["@markup.heading"] = { fg = p.cyan }

groups["@markup.link"] = { fg = p.cyan }
groups["@markup.link.label"] = { fg = p.purple }

groups["@markup.list"] = { fg = p.cyan, bold = true }
groups["@markup.list.unchecked"] = { fg = p.red, bold = true }
groups["@markup.list.checked"] = { fg = p.green, bold = true }

groups["@markup.italic"] = { fg = p.cyan }

for name, config in pairs(groups) do
  hi(name, config)
end
