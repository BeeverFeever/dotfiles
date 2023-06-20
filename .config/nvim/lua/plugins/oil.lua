local oil = utils.get_package("oil")

local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local min_width = 20
local min_height = 20

-- there might be a nicer solution to this but i cant be bothered to think about
-- it right now
local new_width = function()
    if (gwidth / 2) < min_width then
        return min_width
    else
        return math.floor(gwidth / 2)
    end
end

local new_height = function()
    if (gheight / 1.5) < min_height then
        return min_height
    else
        return math.floor(gheight / 1.5)
    end
end

local col = (gwidth / 2) - (new_width() / 2)
local row = (gheight / 2) - (new_height() / 2)

oil.setup({
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
        "permissions",
        "size",
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
        buflisted = true,
        bufhidden = "hide",
    },
    -- Window-local options to use for oil buffers
    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nv",
    },
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
    default_file_explorer = true,
    -- Restore window options to previous values when leaving an oil buffer
    restore_win_options = true,
    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = false,
    -- Deleted files will be removed with the `trash-put` command.
    delete_to_trash = false,
    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    prompt_save_on_select_new_entry = true,
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
            return false
        end,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
        -- Padding around the floating window
        padding = 0,
        max_width = new_width(),
        max_height = new_height(),
        border = settings.border_style,
        win_options = {
            winblend = settings.winblend,
            -- width = col,
            -- height = row,
        },
    },
    -- Configuration for the actions floating preview window
    preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = settings.border_style,
        win_options = {
            winblend = settings.winblend,
        },
    },
    -- Configuration for the floating progress window
    progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = settings.border_style,
        minimized_border = "none",
        win_options = {
            winblend = 0,
        },
    },
})
