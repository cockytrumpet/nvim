---@diagnostic disable: undefined-global

--[[
local ls = require 'luasnip'
-- s(<trigger>, <nodes>)
local s = ls.s --> snippet
-- i(<position>, [<text>])
local i = ls.i --> insert node
-- t(<text>)
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

-- fmt(<fmt_string>, <nodes>)
local fmt = require('luasnip.extras.fmt').fmt
-- rep(<position>)
local rep = require('luasnip.extras').rep
]]

local all = {}

return all
