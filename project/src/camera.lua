-- camera.lua
--// Modules:
local love = require("love")
local data = require("data")

local game = data.game
local camera = data.camera
local player = data.player

local HEIGHT = game.HEIGHT
local WIDTH = game.WIDTH

local methods = {}

--// Functions:
function methods:update(dt)
    local speed = 5
    camera.x = camera.x + ((player.x - WIDTH / 2) - camera.x) * speed * dt
    camera.y = camera.y + ((player.y - HEIGHT / 2) - camera.y) * speed * dt
end

return methods
