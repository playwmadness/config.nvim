local function create_include_guard()
  local filename = vim.fn.expand("%:t")

  if not filename:match("%.h$") then
    return
  end

  local basename = vim.fn.fnamemodify(filename, ":r")
  local guard_name = basename:upper() .. "_H"
  local include_guard = {
    string.format("#ifndef %s", guard_name),
    string.format("# define %s", guard_name),
    "",
    string.format("#endif // %s", guard_name)
  }
  vim.api.nvim_buf_set_lines(0, 0, -1, false, include_guard)
end

vim.api.nvim_create_user_command('IncludeGuard', create_include_guard, {})

vim.cmd [[
  map <F1> :IncludeGuard<CR>
]]
