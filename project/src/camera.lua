---@diagnostic disable: undefined-field
-- camera.lua
--// Modules:
local DataModule = require("data")

local data      =   DataModule.data or {}
local game      =   data.game
local camera    =   data.camera
local player    =   data.player

local HEIGHT    =   game.HEIGHT
local WIDTH     =   game.WIDTH

local methods = {}

--[[
==== Update camera from player
]]--
function methods:update()
    camera.x = math.round(player.x - WIDTH / 2)
    camera.y = math.round(player.y - HEIGHT / 2)
end

return methods
