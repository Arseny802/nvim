local function run_curr_python_file(args)
  local dir_name = vim.fn.expand "%:p:h"
  vim.cmd "vsplit"
  vim.cmd "terminal"
  vim.fn.feedkeys "a"
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
  vim.fn.feedkeys("clear" .. enter)
  vim.fn.feedkeys('python3 /build_tools/builder.py "' .. dir_name .. '" ' .. args .. enter)
  vim.fn.feedkeys("exit" .. enter)
end

local function conan_get_packages(args) run_curr_python_file "--deps" end

local function cmake_reload(args) run_curr_python_file "--cmake" end

local function cmake_build(args) run_curr_python_file "--build" end

vim.api.nvim_set_keymap("n", "<Leader>xd", "", {
  noremap = true,
  callback = conan_get_packages,
  desc = "Conan Install Packages (Dependencies)",
})

vim.api.nvim_set_keymap("n", "<Leader>xc", "", {
  noremap = true,
  callback = cmake_reload,
  desc = "Cmake Reload Project",
})

vim.api.nvim_set_keymap("n", "<Leader>xb", "", {
  noremap = true,
  callback = cmake_build,
  desc = "Cmake Build Project",
})

vim.api.nvim_set_keymap("n", "<Leader>sv", ":source $MYVIMRC", {
  noremap = true,
  desc = "Reloads .vimrc file",
})

return {}
