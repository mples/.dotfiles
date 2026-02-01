local M = {}

-- 1. Get colors once
-- local colors = require('tokyonight.colors').setup { style = 'night' }
local status, tokyo_colors = pcall(require, 'tokyonight.colors')
local colors = status and tokyo_colors.setup { style = 'night' }
    or {
        green = '#98c379',
        blue = '#61afef',
        magenta = '#c678dd',
        error = '#f44747',
        warning = '#ff8800',
        black = '#000000',
        fg_sidebar = '#a9b1d6',
        bg_statusline = '#1a1b26',
    }

-- 2. Define highlights (Added SlError and SlWarning)
local function apply_highlights()
    vim.api.nvim_set_hl(0, 'SlNormal', { fg = colors.black, bg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, 'SlInsert', { fg = colors.black, bg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, 'SlVisual', { fg = colors.black, bg = colors.magenta, bold = true })
    vim.api.nvim_set_hl(0, 'SlGeneric', { fg = colors.fg_sidebar, bg = colors.bg_statusline })
    -- Diagnostic colors matching TokyoNight
    vim.api.nvim_set_hl(0, 'SlError', { fg = colors.error, bg = colors.bg_statusline })
    vim.api.nvim_set_hl(0, 'SlWarning', { fg = colors.warning, bg = colors.bg_statusline })
end

apply_highlights()

-- 3. Diagnostic logic
local function get_diagnostics()
    local result = {}
    -- Count errors
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    if errors > 0 then
        table.insert(result, string.format('%%#SlError# %d', errors))
    end

    -- Count warnings
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if warnings > 0 then
        table.insert(result, string.format('%%#SlWarning# %d', warnings))
    end

    if #result > 0 then
        return ' ' .. table.concat(result, ' ') .. ' %#SlGeneric#'
    end
    return ''
end

local function get_short_path()
    local path = vim.fn.expand '%:~:.:h'
    if path == '.' or path == '' then
        return ''
    end
    return vim.fn.pathshorten(path) .. '/'
end

function M.render()
    local mode_map = {
        ['n'] = { ' NORMAL ', 'SlNormal' },
        ['i'] = { ' INSERT ', 'SlInsert' },
        ['v'] = { ' VISUAL ', 'SlVisual' },
        ['V'] = { ' V-LINE ', 'SlVisual' },
        ['\22'] = { ' V-BLOCK ', 'SlVisual' },
        ['c'] = { ' COMMAND ', 'SlNormal' },
    }

    local mode_data = mode_map[vim.api.nvim_get_mode().mode] or { ' NORMAL ', 'SlNormal' }

    return table.concat {
        string.format('%%#%s#%s', mode_data[2], mode_data[1]),
        '%#SlGeneric# ',
        get_short_path(),
        '%t ',
        '%m',
        '%=',
        get_diagnostics(), -- Diagnostic info inserted here
        '%y ',
        '%l:%c ',
    }
end

return M
