-- button.lua
local Inky = require("libs.inky")

return Inky.defineElement(function(self)

	--[[
	self:onPointer("release", function(_, playerData)
		self.props.money = playerData.inventory.money
	end)--]]

	return function(_, x, y, w, h)
		love.graphics.rectangle("line", x, y, w, h)
		love.graphics.printf(string.format("%s %s", self.props.title, self.props.count or 0), x, y, w, "center")
	end
end)
