-- game.lua
local json = require "libs.dkjson"
local io = require "io"
local os = require "os"

local module = {}

module.data = {
    --[[
    ==== Contains all the game's data to run the game
    ]]--
    game = {
        WIDTH = 1920,
        HEIGHT = 1080,
    },
    --[[
    ==== Camera information
    ]]--
    camera = {
        mode = 1;
        x = 0;
        y = 0;
    },
    --[[
    ==== Contains player's data
    ]]--
    player = {
        x = 0,
        y = 0,
        speed = 2000,
        inventory = {
            money = 0;
        }
    },
}

function module.loadData()
    local file = io.open("data.json", "r")
    local data = nil

    if not file then
        module.saveData()
        file = io.open("data.json", "r")
    end
    data = file:read("*a")
    file:close()
    if not data or data == "" then
        error("Empty or corrupted data.")
    end
    module.data = json.decode(data)
    return true
end

function module.saveData()
    local file, err = io.open("data.json", "w")
    local encodedData = nil

    if not file then
        error("Couldn't save save file " .. tostring(err))
    end
    encodedData = json.encode(module.data, { indent = true })
    file:write(encodedData)
    file:close()
end

module.loadData()

return module