-- inventory.lua
local methods = {}

function methods:giveMoney(amount)
    local inventory = self.inventory

    inventory.money = inventory.money + (amount or 1)
end

return methods