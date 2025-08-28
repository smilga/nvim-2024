return {
	"saghen/blink.cmp",
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		enabled = function()
			-- you list filetypes where you don't want blink blink to work here
			local disabled_filetypes = { "TelescopePrompt", "DressingInput", "AvanteInput" }
			return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype) and vim.b.completion ~= false
		end,
		cmdline = {
			keymap = {
				["<Tab>"] = { "show", "accept" },
				-- Arrow keys are not used in cmdline mode
				["<Down>"] = { "select_next", "show" },
				["<Up>"] = { "select_prev", "show" },
			},
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
						-- enable for inputs as well, with:
						-- or vim.fn.getcmdtype() == '@'
					end,
				},
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			menu = {
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
				end,
			},
			keyword = { range = "prefix" },
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
		signature = {
			enabled = true,
		},
		snippets = { preset = "luasnip" },
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = "enter",
			["<S-Tab>"] = { "select_prev" },
			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			min_keyword_length = function(ctx)
				if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
					return 3
				end
				return 0
			end,
		},
	},
	opts_extend = { "sources.default" },
}
