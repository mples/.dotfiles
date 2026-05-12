return {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

    -- Highlight todo, notes, etc in comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
    },
    {
        -- Tmux & split window navigation
        'christoomey/vim-tmux-navigator',
    },
}
