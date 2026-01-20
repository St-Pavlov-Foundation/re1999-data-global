-- chunkname: @modules/logic/fight/model/data/FightEntityExData.lua

module("modules.logic.fight.model.data.FightEntityExData", package.seeall)

local FightEntityExData = FightDataClass("FightEntityExData")

function FightEntityExData:onConstructor()
	self.aiUseCardList = {}
	self.scaleOffsetDic = {}
end

return FightEntityExData
