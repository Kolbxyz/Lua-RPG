-- button.lua
local Inky = require("libs.inky")

return Inky.defineElement(function(self)

	--[[
	self:onPointer("release", function(_, playerData)
		self.props.money = playerData.inventory.money
	end)--]]

	return function(_, x, y, w, h)
		local color = love.graphics.getColor()
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.rectangle("fill", x, y, w, h)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.printf(string.format("%s %s", self.props.title, self.props.count or 0), x, y, w, "center")
		love.graphics.setColor(color, color, color, 1)
	end
end)
