-- chunkname: @modules/logic/herogroup/model/HeroGroupActivity104EquipMo.lua

module("modules.logic.herogroup.model.HeroGroupActivity104EquipMo", package.seeall)

local HeroGroupActivity104EquipMo = pureTable("HeroGroupActivity104EquipMo")

function HeroGroupActivity104EquipMo:init(info)
	self.index = info.index

	if self.index == 4 then
		if not self._mainCardNum then
			local equipUid = info.equipUid and info.equipUid[1] or "0"

			self.equipUid = {
				equipUid
			}
		else
			self.equipUid = {}

			for i = 1, self._mainCardNum do
				local equipUid = info.equipUid and info.equipUid[i] or "0"

				table.insert(self.equipUid, equipUid)
			end
		end
	else
		self.equipUid = {}

		if not self._normalCardNum then
			for i = 1, 2 do
				local equipUid = info.equipUid and info.equipUid[i] or "0"

				table.insert(self.equipUid, equipUid)
			end
		else
			for i = 1, self._normalCardNum do
				local equipUid = info.equipUid and info.equipUid[i] or "0"

				table.insert(self.equipUid, equipUid)
			end
		end
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
