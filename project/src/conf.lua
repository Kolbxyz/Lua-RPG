-- conf.lua
local dataModule = require("data")
local data = dataModule.data or {}

--[[
==== To be executed once at program's execution
==== Configures window
]]--
function love.conf(t)
    t.window.width = data.game.WIDTH
    t.window.height = data.game.HEIGHT
    t.window.title = ("Lua RPG")
    t.window.resizable = false
    t.window.vsync = true
end
