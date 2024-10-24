local ls = require("luasnip")
local snippets = {}
local i = ls.insert_node
local s = ls.snippet
--
local fmt = require("luasnip.extras.fmt").fmt
--
local log = s({ trig = "log" }, fmt([[console.log({})]], { i(1, "") }))
--
table.insert(snippets, log)
--
return snippets
