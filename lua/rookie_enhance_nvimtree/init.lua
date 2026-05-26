local M = {}
local actions = require("rookie_enhance_nvimtree.actions")
local keymaps = require("rookie_enhance_nvimtree.keymaps")

function M.setup(opts)
    opts = opts or {}

    -- Global mappings
    keymaps.setup()

    -- Command for RemoveBuffersNotUnderRoot
    vim.api.nvim_create_user_command(
        "NvimTreeRemoveBuffersNotUnderRoot",
        actions.remove_buffers_not_under_root,
        {}
    )

    -- Command to copy current CWD and 'nvim' start command to clipboard then exit
    vim.api.nvim_create_user_command("CD", function()
        -- Copy 'cd [current_path]; nvim' to the system clipboard
        vim.fn.setreg("+", "cd " .. vim.fn.getcwd() .. "; nvim")
        -- Quit all windows
        vim.cmd("qa")
    end, {})

    local default_opts = {
        on_attach = keymaps.on_attach,
        view = {
            width = 40,
        },
        filters = {
            dotfiles = false,
            git_ignored = false,
        },
        filesystem_watchers = {
            enable = false,
        }
    }

    require("nvim-tree").setup(vim.tbl_deep_extend("force", default_opts, opts))
end

return M
