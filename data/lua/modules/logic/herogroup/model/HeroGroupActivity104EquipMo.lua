-- chunkname: @modules/logic/herogroup/model/HeroGroupActivity104EquipMo.lua

module("modules.logic.herogroup.model.HeroGroupActivity104EquipMo", package.seeall)

local HeroGroupActivity104EquipMo = pureTable("HeroGroupActivity104EquipMo")

function HeroGroupActivity104EquipMo:init(info)
	self.index = info.index

	local cardNum = self.index == 4 and (self._mainCardNum or 1) or self._normalCardNum or 2

	self.equipUid = {}

	for i = 1, cardNum do
		local equipUid = info.equipUid and info.equipUid[i] or "0"

		table.insert(self.equipUid, equipUid)
	end
end

function HeroGroupActivity104EquipMo:setLimitNum(mainCardNum, normalCardNum)
	self._mainCardNum, self._normalCardNum = mainCardNum, normalCardNum
end

function HeroGroupActivity104EquipMo:getEquipUID(slot)
	if not self.equipUid then
		return
	end

	return self.equipUid[slot]
end

return HeroGroupActivity104EquipMo
