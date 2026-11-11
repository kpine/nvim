-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('options')
require('keymaps')

-- Experimental: ui2 message/cmdline redesign (:h ui2)
-- Avoids "Press ENTER" prompts, highlights cmdline, pager as buffer.
require('vim._core.ui2').enable()
