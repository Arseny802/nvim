local function run_curr_python_file()
  local dir_name = vim.fn.expand "%:p:h"
  vim.cmd "vsplit"
  vim.cmd "terminal"
  vim.fn.feedkeys "a"
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
  vim.fn.feedkeys("clear" .. enter)
  vim.fn.feedkeys('python3 /build_tools/builder.py "' .. dir_name .. '" --deps' .. enter)
end

vim.api.nvim_set_keymap("n", "<Leader>xx", "", {
  noremap = true,
  callback = run_curr_python_file,
  desc = 'Prints "My example" in the message area',
})

vim.api.nvim_set_keymap("n", "<Leader>sv", ":source $MYVIMRC", {
  noremap = true,
  desc = "Reloads .vimrc file",
})

return {}
