-- movements.lua
local love = require("love")
local data = require("data")

local methods = {}

--// Functions:
function methods:movements(dt)
    local player = self
    local player_speed = player.speed * dt
    local vertical_limiter = (love.keyboard.isDown('d') or love.keyboard.isDown('q')) and 2 or 1
    local horizontal_limiter   = (love.keyboard.isDown('z') or love.keyboard.isDown('s')) and 2 or 1

    if love.keyboard.isDown('d') then player.x = (player.x + player_speed / horizontal_limiter) end
    if love.keyboard.isDown('q') then player.x = (player.x - player_speed / horizontal_limiter) end
    if love.keyboard.isDown('z') then player.y = (player.y - player_speed / vertical_limiter) end
    if love.keyboard.isDown('s') then player.y = (player.y + player_speed / vertical_limiter) end
end

return methods
