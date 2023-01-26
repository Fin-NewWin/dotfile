return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local status_ok, npairs = pcall(require, "nvim-autopairs")
        if not status_ok then
            vim.notify("nvim-autopairs not in path", 4, { title = "Plugin Error" })
            return
        end

        npairs.setup({
            check_ts = true,
            disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
        })

        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
            vim.notify("cmp not in path", 4, { title = "Plugin Error" })
            return
        end
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
}
