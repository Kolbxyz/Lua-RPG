-- conf.lua
local dataModule = require("data")
local data = dataModule.data

--[[
==== To be executed once at program's execution
==== Configures window
]]--
function love.conf(t)
    t.window.width = data.game.WIDTH
    t.window.height = data.game.HEIGHT
end
