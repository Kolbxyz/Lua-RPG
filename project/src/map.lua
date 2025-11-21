-- map.lua
--// Modules
local Json = require "libs.dkjson"

-- Method
local map = {}

--[[
==== Loads quads into the given state
]]--
local function loadQuads(state, tilesetData)
    local cols = tilesetData.columns
    local rows = tilesetData.tilecount / cols
    local tileWidth, tileHeight = tilesetData.tileheight, tilesetData.tileheight

    state.map.quads = {}
    for y = 0, rows - 1 do
        for x = 0, cols - 1 do
            table.insert(state.map.quads, love.graphics.newQuad(
                x * tileWidth, y * tileHeight, tileWidth, tileHeight,
                state.map.tilesetImage:getDimensions()
            ))
        end
    end
end

--[[
==== Loads the map inside state from the given mapData
]]--
local function loadMap(state, mapData)
    state.map.tilemap = {}
    for layerIndex, layer in ipairs(mapData.layers) do
        if layer.type ~= "tilelayer" then break end
        state.map.tilemap[layerIndex] = {}
        local chunkX, chunkY = layer.x, layer.y
		local w, h = layer.width, layer.height

        for y = 0, h - 1 do
            local row = chunkY + y + 1
            state.map.tilemap[layerIndex][row] = state.map.tilemap[layerIndex][row] or {}
            for x = 0, w - 1 do
                local col = chunkX + x + 1
                state.map.tilemap[layerIndex][row][col] = layer.data[y * w + x + 1]
            end
        end
        state.map.offsetx[layerIndex] = layer.offsetx or 0
        state.map.offsety[layerIndex] = layer.offsety or 0
    end
end

--[[
==== Takes the current state as argument and loads the map from the given tileset
==== Will directly place the map's data inside state
]]--
function map.load(state, name, tileset)
    local tileset_f = love.filesystem.read(string.format("assets/maps/tilesets/%s.tsj", name or "island"))
    local map_f = love.filesystem.read(string.format("assets/maps/data/%s.json", name or "island"))
    local tilesetData = Json.decode(tileset_f)
    local mapData = Json.decode(map_f)

    state.map.tilesetImage = love.graphics.newImage(string.format("assets/maps/tilemaps/%s.png", tileset or "diverse"))
    loadQuads(state, tilesetData)
    loadMap(state, mapData)
end

--[[
==== Render the map from state
]]--
function map.render(state)
    for l, layer in ipairs(state.map.tilemap) do
        for i, row in pairs(layer) do
            for j, tile in ipairs(row) do
                if tile ~= 0 and state.map.quads[tile] then
                    love.graphics.draw(state.map.tilesetImage,
                        state.map.quads[tile],
                        j * 16 + state.map.offsetx[l],
                        i * 16 + state.map.offsety[l])
                end
            end
        end
    end
end

return map
