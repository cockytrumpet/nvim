---@diagnostic disable: undefined-global, unused-local

-- this isn't behaving like it's supposed to
-- it's behaving like rep(1)
local same = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

local lua = {
  s('rq', fmt("local {} = require('{}')", { i(1), rep(1) })),
  s(
    { trig = 'b(%d)', regTrig = true },
    f(function(args, snip)
      return 'Captured Text: ' .. snip.captures[1] .. '.'
    end, {})
  ),
  s('sametest', fmt('example: {} = {}', { i(1), same(1) })),
}

return lua
