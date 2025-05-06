return {
    "j-hui/fidget.nvim",
    enable = true,
    config = function()
        local fidget = require 'fidget'
        fidget.setup()
    end
}
