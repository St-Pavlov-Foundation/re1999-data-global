-- chunkname: @modules/logic/fight/model/data/FightDataBloodPool.lua

module("modules.logic.fight.model.data.FightDataBloodPool", package.seeall)

local FightDataBloodPool = FightDataClass("FightDataBloodPool")

function FightDataBloodPool:onConstructor(bloodPool)
	self.value = bloodPool and bloodPool.value or 0
	self.max = bloodPool and bloodPool.max or 0
end

function FightDataBloodPool:changeMaxValue(value)
	self.max = self.max + value
end

function FightDataBloodPool:changeValue(value)
	self.value = self.value + value
end

return FightDataBloodPool
