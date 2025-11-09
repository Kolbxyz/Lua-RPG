-- player.lua
local dataModule    =   require("data")
local os            =   require("os")

local data          =   dataModule.data or {}
local game          =   data.game

local methods = {}

--[[
==== Loads quads into the given state for player animations
]]--
local function loadQuads(state)
    state.player.quads = {}
    for y = 0, 3 do
        for x = 0, 2 do
            table.insert(state.player.quads, love.graphics.newQuad(
                x * 32, y * 32, 32, 32,
                state.player.tilesetImage:getDimensions()
            ))
        end
    end
end

--[[
==== Takes the current state as argument and loads the map from the given tileset
==== Will directly place player's tilesetImage into state.player
]]--
function methods.load(state, name)
    state.player.tilesetImage = love.graphics.newImage(string.format("assets/characters/%s.png", name or "Male/Male 01-1"))
    loadQuads(state)
end

--[[
==== Render the map from state
]]--
function methods:render(state)
    local player = self
    local quadIndex = state.player.animationTick + (3 * (player.direction - 1))

    if love.keyboard.isDown('s', "q", "d", "z") then
        if os.clock() - state.player.animationTickTime > .09 then
            state.player.animationTick = state.player.animationTick >= 3 and 1 or state.player.animationTick + 1
            state.player.animationTickTime = os.clock()
        end
    else
        state.player.animationTick = 1
    end
    if quadIndex > #state.player.quads then
        print("Requested quad goes beyond the limit: ", quadIndex, #state.player.quads)
        return
    end
    love.graphics.draw(state.player.tilesetImage, state.player.quads[quadIndex], game.WIDTH / 2, game.HEIGHT / 2)
end

--[[
==== Process input and move the player accordingly
]]--
function methods:movements(dt, state)
    local player = self
    local player_speed = player.speed * dt
    local vertical_limiter = (love.keyboard.isDown('d') or love.keyboard.isDown('q')) and 2 or 1
    local horizontal_limiter   = (love.keyboard.isDown('z') or love.keyboard.isDown('s')) and 2 or 1

    -- Prevents "double speed" if moving horizontally and vertically simultaneously
    if love.keyboard.isDown('d') then player.x = (player.x + player_speed / horizontal_limiter) end
    if love.keyboard.isDown('q') then player.x = (player.x - player_speed / horizontal_limiter) end
    if love.keyboard.isDown('z') then player.y = (player.y - player_speed / vertical_limiter) end
    if love.keyboard.isDown('s') then player.y = (player.y + player_speed / vertical_limiter) end

    player.direction = love.keyboard.isDown('s') and 1 or player.direction -- Player is facing down
    player.direction = love.keyboard.isDown('q') and 2 or player.direction -- Player is facing left
    player.direction = love.keyboard.isDown('d') and 3 or player.direction -- Player is facing right
    player.direction = love.keyboard.isDown('z') and 4 or player.direction -- Player is facing up
end

return methods
