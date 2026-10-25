return {
    "lervag/vimtex",
    ft = { "latex", "tex", "plaintex" },
    lazy = true, -- 不要延迟加载，否则无法实时预览
    init = function()
        local servername = "/tmp/nvim"
        local sock_exists = vim.loop.fs_stat(servername)

        if not sock_exists then
            local ok, err = pcall(vim.fn.serverstart, servername)
            if not ok then
                print("Failed to start nvim server: " .. err)
            end
        else
            -- 已存在 socket，确认是否可用或直接用它
            vim.g.nvim_servername = servername
        end

        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode = 0

        vim.g.vimtex_compiler_latexmk = {
            out_dir = "build", -- 指定中间文件和 PDF 输出放入 build 文件夹
            callback = 1,
            continuous = 0,
            executable = "latexmk",
            engine = "lualatex",
            options = {
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-output-directory=build", -- 实际告诉 latexmk 输出到 build/
            },
        }

        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_view_general_viewer = "zathura"
        vim.g.vimtex_compiler_typst = {}

        -- vim.g.vimtex_view_method = "general"
        -- vim.g.vimtex_view_general_viewer = "okular"
        -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
        -- vim.g.vimtex_view_general_options = "--unique file:@pdf"
    end,
}
