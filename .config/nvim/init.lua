if require("first-run")() then
    return
end

require("options")
require("keymaps")
require("plugins.manager")
require("lsp")

require("auto-cmds")

-- for catppuccin provide a flavour as the second argument
require("plugins.configs.colourschemes").set_theme("catppuccin", "mocha")

-- idk why but this doesnt edit the hl group, it only works when being called in
-- the nvim-tree config file. maybe it only works once nvim-tree has been
-- required?? but it should be at this point, if someone by any chance reads this and is
-- able to figure it out please tell me
-- require("utils").get_package("custom-hl-groups").float_titles()
