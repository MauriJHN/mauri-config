-- this script contains operations needed at the end of the config

local pattern_all = { "*" }

-- AUTOCMD

-- makes background transparent independent of theme
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = pattern_all,
    command = "hi Normal ctermbg=none guibg=none"
})

-- bind Jenkinsfiles to groovy syntax
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "Jenkinsfile", "Jenkinsfile_dev" },
    command = "setf groovy"
})

-- format python files when writing to them
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.py" },
    -- command = "lua vim.lsp.buf.formatting_sync(nil, 100)"
    command = [[lua 
                if vim.g.pythonformatting then
                    vim.cmd('!python3 -m black -q %')
                end]]
})

-- use the windows clipboard when yanking to * registry ONLY in wsl
if vim.fn.has("wsl") then
    vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        pattern = { "*" },
        command = "call system('/mnt/c/windows/system32/clip.exe ',@\")"
    })
end

vim.cmd "colo neosolarized"