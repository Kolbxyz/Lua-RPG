-- maths.lua
local methods = {}

function methods.round(n)
    return math.floor((n * 10 + 0.5) / 10)
end

return methods