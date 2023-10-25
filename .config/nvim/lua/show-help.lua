local M = {}

vim.cmd([[
  highlight HelpHeader guifg=#ff8700
  syntax clear HelpHeader
  syntax match HelpHeader "^.*:$"
]])

M.help_content = {
    "Neovim Key Mappings and Commands",
    "",
    "LSP Mappings:",
    "gd: Go to definition",
    "K: Show hover information",
    "<leader>vws: Search workspace symbols",
    "<leader>vd: Open floating diagnostic",
    "[d: Go to next diagnostic",
    "]d: Go to previous diagnostic",
    "<leader>vca: Show code actions",
    "<leader>vrr: Show references",
    "<leader>vrn: Rename symbol",
    "<C-h> (Insert mode): Show signature help",
    "",
    "Telescope Mappings:",
    "<leader>ff: Find files",
    "<C-p>: Find files",
    "<leader>fg: Live grep",
    "<leader>fb: Show buffers",
    "<leader>fh: Show help tags",
    "",
    "Copilot Mappings:",
    "[[: Jump to previous placeholder",
    "]]: Jump to next placeholder",
    "<CR> (Insert mode): Accept copilot suggestion",
    "gr: Refresh copilot panel",
    "<M-CR>: Open copilot panel",
    "<M-l> (Insert mode): Accept copilot suggestion",
    "<M-]> (Insert mode): Go to next copilot suggestion",
    "<M-[> (Insert mode): Go to previous copilot suggestion",
    "<C-]> (Insert mode): Dismiss copilot suggestion",
    "",
    "Miscellaneous Mappings:",
    "<leader>t: Open floating terminal (esc closes)",
    "Press 'q' or '<ESC>' to close this window."
}

function M.show_help()
    local width = 60
    local height = #M.help_content  -- Here, reference the help_content as M.help_content
    local row = (vim.o.lines - height) / 2
    local col = (vim.o.columns - width) / 2

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, M.help_content)  -- Here as well
    vim.api.nvim_buf_set_option(buf, 'filetype', 'help')
    vim.api.nvim_buf_set_option(buf, 'syntax', 'ON')

    -- Apply custom highlighting
    vim.api.nvim_buf_call(buf, function()
        vim.cmd('setlocal syntax=help')
        vim.cmd('syn include @HelpHeader syntax/help.vim')
        vim.cmd('hi link HelpHeader HelpHeader')
    end)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_command("au BufLeave <buffer> :q")

    -- Map all keys to close the popup
    local keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890`~!@#$%^&*()-_=+[]{}\\|;:\'",.<>?/'
    for i = 1, #keys do
        local key = keys:sub(i, i)
        vim.api.nvim_buf_set_keymap(buf, 'n', key, ':q<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'i', key, '<Esc>:q<CR>', { noremap = true, silent = true })
    end
    -- Map Escape key to close the popup
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'i', '<Esc>', '<Esc>:q<CR>', { noremap = true, silent = true })

end

vim.api.nvim_set_keymap('n', '<leader>hk', ':lua require("show-help").show_help()<CR>', { noremap = true, silent = true })  -- And update the require statement if needed

vim.api.nvim_create_user_command('ShowHelp', 'lua require"show-help".show_help()', {})

return M
