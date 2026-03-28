vim.api.nvim_create_autocmd("FileType", { -- disable spell checking
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = false
    vim.cmd('set foldmethod=manual')
    vim.cmd('loadview')
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, { --
  pattern = "*.md",
  callback = function()
    vim.cmd("normal! zM")
    vim.cmd('mkview')
  end,
})
