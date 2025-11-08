-- conf.lua
local game = require("data")
local love = require("love")

function love.conf(t)
    t.window.width = game.game.WIDTH
    t.window.height = game.game.HEIGHT
end
