-- main.lua
local os            =   require("os")
local dataModule    =   require("data")
local cameraModule  =   require("camera")
local playerModule  =   require("player")
local mapModule     =   require("map")
local musicModule   =   require("music")

local data      =   dataModule.data or {}
local player    =   data.player
local camera    =   data.camera

local state = {
    --[[
    ==== Contains all the game's data to run the game
    ]]--
    game = {
        hasLoaded = false,
	    background = nil,
    },
    map = {
        tilesetImage = nil,
	    tilemap = {},
	    quads = {},
    },
    player = {
        animationTickTime = os.clock(),
        animationTick = 1,
        tilesetImage = nil,
        quads = {},
    },
    music = {},
}

--[[
==== To be executed once at program's execution
]]--
function love.load()
    setmetatable(player, {__index = playerModule})
    setmetatable(camera, {__index = cameraModule})

    state.game.background = love.graphics.newImage('assets/background.jpg')
    musicModule.load(state, "music", false, true)
    mapModule.load(state, "test", "Basics")
    playerModule.load(state, "Male/Male 01-1")

    state.game.hasLoaded = true
end

--[[
==== Refresh screen
]]--
function love.draw()
    love.graphics.clear()
    love.graphics.draw(state.game.background, 0, 0)
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
    mapModule.render(state)
    love.graphics.pop()
    player:render(state)
end

--[[
==== To be executed every frame
]]--
function love.update(dt)
    player:movements(dt, state)
    camera:update(dt)
end

love.quit = dataModule.saveData
