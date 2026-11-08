require("mini.notify").setup({
	-- no timestamp, only messages
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
})
