-- main.lua
local love = require("love")

--// Modules:
local data = require("data")
local cameraModule = require("camera")
local playerModule = require("player")

--// VALUES:
local game = data.game
local player = data.player
local camera = data.camera

local background = nil

function love.load()
    Tileset = love.graphics.newImage("assets/tilemap.png")
    local image_width = Tileset:getWidth()
    local image_height = Tileset:getHeight()
    Width = (image_width / 3) - 2
    Height = (image_height / 2) - 2
    Quads = {}

    for y = 0, 1 do
        for x = 0, 2 do
            local newQuad = love.graphics.newQuad(1 + x * (Width + 2), 1 + y * (Height + 2), Width, Height, image_width, image_height)
            table.insert(Quads, newQuad)
        end
    end
    Tilemap = {
        {1, 6, 6, 2, 1, 6, 6, 2},
        {3, 0, 0, 4, 5, 0, 0, 3},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {4, 2, 0, 0, 0, 0, 1, 5},
        {1, 5, 0, 0, 0, 0, 4, 2},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {3, 0, 0, 1, 2, 0, 0, 3},
        {4, 6, 6, 5, 4, 6, 6, 5}
    }
    setmetatable(player, {__index = playerModule})
    setmetatable(camera, {__index = cameraModule})
    background = love.graphics.newImage('assets/background.jpg')
end

function love.draw()
    love.graphics.clear()
    love.graphics.draw(background, 0, 0)

    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)

    for i, row in ipairs(Tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(Tileset, Quads[tile], j * Width, i * Height)
            end
        end
    end

    love.graphics.pop()
    love.graphics.circle("fill", game.WIDTH / 2, game.HEIGHT / 2, 10, 8)
end

function love.update(dt)
    player:movements(dt)
    camera:update(dt)
end
