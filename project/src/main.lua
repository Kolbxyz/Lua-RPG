-- main.lua
local os                = require("os")
local DataModule        = require("data")
local CameraModule      = require("camera")
local PlayerModule      = require("player")
local MapModule         = require("map")
local MusicModule       = require("music")
local InventoryModule   = require("inventory")
local InterfaceModule   = require("interface")
local MathsModule       = require("libs.maths")

local data      =   DataModule.data or {}
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
        offsetx = {},
        offsety = {},
        tileWidth = 0,
        tileHeight = 0,
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
    local font = love.graphics.newFont("assets/Kanit-Regular.ttf", 30)

    love.graphics.setFont(font)
    setmetatable(PlayerModule, {__index = InventoryModule})
    setmetatable(player, {__index = PlayerModule})
    setmetatable(camera, {__index = CameraModule})
    setmetatable(math, {__index = MathsModule})

    state.game.background = love.graphics.newImage('assets/background.jpg')
    MusicModule.load(state, "music", false, true)
    MapModule.load(state, "island", "diverse")
    PlayerModule.load(state, "Male/Male 01-1")

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
    MapModule.render(state)

    love.graphics.pop()
    player:render(state)
    player:giveMoney(.1)
    InterfaceModule.render(player);
end

--[[
==== To be executed every frame
]]--
function love.update(dt)
    InterfaceModule.updatePtr()
    player:movements(dt, state)
    camera:update()
end

--[[
==== Sends a signal for the user interface
]]--
function love.mousereleased(x, y, button)
	if (button == 1) then
		InterfaceModule.pointer:raise("release", player)
	end
end

love.quit = DataModule.saveData
