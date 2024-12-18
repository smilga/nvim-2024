local ls = require("luasnip")
local snippets = {}
local i = ls.insert_node
local s = ls.snippet
--
local fmt = require("luasnip.extras.fmt").fmt
--
local tts = s("tts", fmt([[
<script lang="ts" setup>
console.log('Hello world!')
</script>

<template>
{}
</template>
]], {
    i(1, ""),
}))

local prps = s("prps", fmt([[
defineProps<{{
  {}
}}>()]],
    {
        i(1, ""),
    }))

local dprps = s("dprps", fmt([[
const props = withDefaults(defineProps<{{
  {}
}}>(), {{
}});
]], {
    i(1, ""),
}))

local emt = s("emt", fmt([[
const emit = defineEmits<{{
  (e: '{}'): void
}}>()
]], {
    i(1, ""),
}))

local ttl = s("ttl", fmt([[
<template>
{}
</template>

<script>
export default {{
}}
</script>
<style scoped lang="scss">
</style>
]], {
    i(1, ""),
}))

local log = s({ trig = "log" }, fmt([[console.log({})]], { i(1, "") }))
--
table.insert(snippets, tts)
table.insert(snippets, ttl)
table.insert(snippets, log)
table.insert(snippets, prps)
table.insert(snippets, dprps)
table.insert(snippets, emt)
--
return snippets
--
-- local t = ls.text_node

-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
-- return {
--   -- A snippet that expands the trigger "hi" into the string "Hello, world!".
--   require("luasnip").snippet(
--     { trig = "test" },
--     { t("Hello, world!") }
--   ),
--
--   -- To return multiple snippets, use one `return` statement per snippet file
--   -- and return a table of Lua snippets.
--   require("luasnip").snippet(
--     { trig = "log" },
--     { fmt([[console.log({})]], {i(1, "")}) }
--   ),
-- }
