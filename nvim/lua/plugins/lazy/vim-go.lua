return {
    "fatih/vim-go",
    config = function ()

        vim.g.go_highlight_extra_types = 1
        vim.g.go_highlight_function_calls = 1
        vim.g.go_highlight_types = 1
        vim.g.go_highlight_fields = 1
        vim.g.go_highlight_functions = 1
        vim.g.go_highlight_trailing_whitespace_error = 1
        vim.g.go_highlight_operators = 1
        vim.g.go_highlight_space_tab_error = 1
        vim.g.go_highlight_variable_declarations = 0
        vim.g.go_auto_type_info = 1
        --vim.g.go_auto_sameids = 1

        --vim.g.go_metalinter_autosave = 1
        vim.g.go_metalinter_autosave_enabled = {'govet', 'staticcheck', 'errcheck'}
        vim.g.go_metalinter_enabled = {'govet', 'staticcheck', 'errcheck'}
        vim.g.go_list_type = "quickfix"
        vim.g.go_autodetect_gopath = 1
        vim.g.go_metalinter_command = "golangci-lint"

        --vim.g.go_fmt_command = "goimports"

        vim.keymap.set("n", "<leader>vet", "<cmd> GoVet ./... <CR>")
    end
}
