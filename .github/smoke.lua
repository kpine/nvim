-- Startup smoke test for CI: start the real build, open a file, and fail on any error message.
-- Run with: nix run .#neovim -- --headless -c "luafile .github/smoke.lua"
-- Open a file so ftplugins, treesitter and the LSP config get exercised too
vim.cmd.edit('flake.nix')
local msgs = vim.fn.execute('messages')
if msgs:find('E%d+:') or msgs:find('Error') then
  io.stderr:write(msgs .. '\n')
  vim.cmd.cquit()
end
vim.cmd.qall()
