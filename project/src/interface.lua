-- interface.lua
local Inky              = require("libs.inky")
local Button            = require("components.textLabel")

local interface = {
    scene = Inky.scene(),
    elements = {}
}

interface.elements.MoneyLabel = Button(interface.scene)
interface.elements.PositionLabel = Button(interface.scene)
interface.pointer = Inky.pointer(interface.scene)

interface.elements.MoneyLabel.props.title = "Money: "
interface.elements.PositionLabel.props.title = "Position: "


--[[
==== Update pointer's location
]]--
function interface.updatePtr()
    local mx, my = love.mouse.getX(), love.mouse.getY()

    interface.pointer:setPosition(mx, my)
end

--[[
==== Render the user interface
]]--
function interface.render(playerData)
    local MoneyLabel = interface.elements.MoneyLabel
    local PositionLabel = interface.elements.PositionLabel

    interface.scene:beginFrame()

    PositionLabel.props.count = string.format("x: %.2f", playerData.x) .. " y: " .. string.format("%.2f", playerData.y)
    MoneyLabel.props.count = string.format("%.0f", playerData.inventory.money)

    MoneyLabel:render(10, 10, 500, 50)
    PositionLabel:render(10, 60, 500, 50)

    interface.scene:finishFrame()
end

return interface