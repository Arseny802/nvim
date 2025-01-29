return {
    'pieces-app/plugin_neovim',
    lazy = false,
    dependencies = {"kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim", "hrsh7th/nvim-cmp"},
    opts = {
        config = {
            host = "http://localhost:1000"
        }
    }
}
