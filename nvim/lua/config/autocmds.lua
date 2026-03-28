vim.api.nvim_create_autocmd("FileType", { -- markdowns: disable spell checking, set manuals folds
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.foldmethod = "manual"
    vim.cmd('loadview')
  end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, { -- markdowns: save folds
  pattern = "*.md",
  callback = function()
    vim.cmd("normal! zM")
    vim.cmd('mkview')
  end,
})
