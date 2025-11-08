-- main.lua
--// Modules:
local dataModule    =   require("data")
local cameraModule  =   require("camera")
local playerModule  =   require("player")
local mapModule     =   require("map")
local musicModule   =   require("music")

local data      =   dataModule.data
local game      =   data.game
local player    =   data.player
local camera    =   data.camera

local state = {
    hasLoaded = false,
	background = nil,
	tilesetImage = nil,
	tilemap = {},
	mapQuads = {},
	music = {},
}

--[[
==== To be executed once at program's execution
]]--
function love.load()
    setmetatable(player, {__index = playerModule})
    setmetatable(camera, {__index = cameraModule})

    musicModule.load(state, "music", false, true)
    mapModule.load(state, "test", "Basics")
    state.background = love.graphics.newImage('assets/background.jpg')
    state.hasLoaded = true
end

--[[
==== Refresh screen
]]--
function love.draw()
    love.graphics.clear()
    love.graphics.draw(state.background, 0, 0)
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
    mapModule.render(state)
    love.graphics.pop()
    love.graphics.circle("fill", game.WIDTH / 2, game.HEIGHT / 2, 10, 8)
end

--[[
==== To be executed every frame
]]--
function love.update(dt)
    player:movements(dt)
    camera:update(dt)
end

love.quit = dataModule.saveData
