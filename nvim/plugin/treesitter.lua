-- Treesitter: highlighting, indentation and folds for any filetype with a parser.
-- Parsers and queries are provided by nix (see module.nix); nothing is installed at runtime.

-- Per-feature opt-outs. Entries may be a treesitter language or a filetype name,
-- e.g. `indent = { "python" }` to keep python's regular indent script.
local disabled = {
  highlight = {},
  indent = {},
  fold = {},
}

-- Languages that should keep regex `syntax` running alongside treesitter
-- (some filetype features, e.g. certain spell/conceal regions, rely on it).
local keep_vim_syntax = {}

local function is_disabled(list, lang, filetype) return vim.tbl_contains(list, lang) or vim.tbl_contains(list, filetype) end

-- Register cleanup that Neovim runs when the buffer's filetype changes,
-- so settings from the previous filetype don't linger.
local function add_undo_ftplugin(buf, command)
  local undo = vim.b[buf].undo_ftplugin
  vim.b[buf].undo_ftplugin = (undo and undo ~= '') and (undo .. ' | ' .. command) or command
end

local augroup = vim.api.nvim_create_augroup('my-treesitter', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local lang = vim.treesitter.language.get_lang(filetype)
    if not lang or not vim.treesitter.language.add(lang) then return end

    local function has_query(query_name) return vim.treesitter.query.get(lang, query_name) ~= nil end

    -- Highlighting: only with a highlights query, since `start()` turns off regex syntax.
    if has_query('highlights') and not is_disabled(disabled.highlight, lang, filetype) then
      vim.treesitter.start(buf, lang)
      add_undo_ftplugin(buf, ('call v:lua.vim.treesitter.stop(%d)'):format(buf))

      if is_disabled(keep_vim_syntax, lang, filetype) then vim.bo[buf].syntax = 'ON' end
    end

    -- Indentation: only with an indents query, otherwise keep the filetype's indent script.
    if has_query('indents') and not is_disabled(disabled.indent, lang, filetype) then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      add_undo_ftplugin(buf, 'setlocal indentexpr<')
    end

    -- Folds: `vim.wo[0][0]` targets the current window, so only apply when this buffer is in it.
    -- Folds start open via `foldlevel` in lua/options.lua.
    if
      has_query('folds')
      and not is_disabled(disabled.fold, lang, filetype)
      and vim.api.nvim_get_current_buf() == buf
    then
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      add_undo_ftplugin(buf, 'setlocal foldexpr< foldmethod<')
    end
  end,
})
