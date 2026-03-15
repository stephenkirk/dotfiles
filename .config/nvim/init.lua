vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

require("config.lazy")
