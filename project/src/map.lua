-- map.lua
--// Modules
local json = require "libs.dkjson"

-- Method
local map = {}

--[[
==== Loads quads into the given state
]]--
local function loadQuads(state, tilesetData)
    local cols = tilesetData.columns
    local rows = tilesetData.tilecount / cols
    local tileWidth, tileHeight = tilesetData.tileheight, tilesetData.tileheight

    state.mapQuads = {}
    for y = 0, rows - 1 do
        for x = 0, cols - 1 do
            table.insert(state.mapQuads, love.graphics.newQuad(
                x * tileWidth, y * tileHeight, tileWidth, tileHeight,
                state.tilesetImage:getDimensions()
            ))
        end
    end
end

--[[
==== Loads the map inside state from the given mapData
]]--
local function loadMap(state, mapData)
    state.tilemap = {}
    for _, layer in ipairs(mapData.layers) do
        if layer.type ~= "tilelayer" then break end
		for _, chunk in ipairs(layer.chunks) do
			local chunkX, chunkY = chunk.x, chunk.y
			local w, h = chunk.width, chunk.height

			for y = 0, h - 1 do
				local row = chunkY + y + 1
				state.tilemap[row] = state.tilemap[row] or {}
				for x = 0, w - 1 do
					local col = chunkX + x + 1
					state.tilemap[row][col] = chunk.data[y * w + x + 1]
				end
			end
		end
    end
end

--[[
==== Takes the current state as argument and loads the map from the given tileset
==== Will directly place the map's data inside state
]]--
function map.load(state, map, tileset)
    local tileset_f = love.filesystem.read(string.format("data/maps/tilesets/%s.tsj", map or "test"))
    local map_f = love.filesystem.read(string.format("data/maps/data/%s.json", map or "test"))
    local tilesetData = json.decode(tileset_f)
    local mapData = json.decode(map_f)

    state.tilesetImage = love.graphics.newImage(string.format("data/maps/tilemaps/%s.png", tileset or "Basics"))
    loadQuads(state, tilesetData)
    loadMap(state, mapData)
end

--[[
==== Render the map from state
]]--
function map.render(state)
    for i, row in ipairs(state.tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(state.tilesetImage, state.mapQuads[tile], j * 48, i * 48)
            end
        end
    end
end

return map
