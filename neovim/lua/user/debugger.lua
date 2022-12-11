local status_ok, dap = pcall(require, 'dap')
if not status_ok then
	return
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/haninger/.config/nvim/extension/debugAdapters/bin/OpenDebugAD7',
  
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

local opts = { noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>di", ":lua local widgets = require'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<CR>", opts)
keymap("n", "<leader>df", ":lua local widgets = require'dap.ui.widgets'; widgets.centered_float(widgets.frames)<CR>", opts)
keymap("n", "<leader>dk", ":lua require'dap'.up()<CR>", opts)
keymap("n", "<leader>dj", ":lua require'dap'.down()<CR>", opts)
keymap("n", "<S-j>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<leader>dn", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)


