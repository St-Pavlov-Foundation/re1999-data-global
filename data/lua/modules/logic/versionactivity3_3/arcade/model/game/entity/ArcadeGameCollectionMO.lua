-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameCollectionMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameCollectionMO", package.seeall)

local ArcadeGameCollectionMO = class("ArcadeGameCollectionMO")

function ArcadeGameCollectionMO:ctor(uid, id, usedTimes, durability)
	self.uid = uid
	self.id = id
	self._skillSetMO = ArcadeGameSkillSetMO.New(uid, self)
	self._usedTimes = usedTimes or 0
	self._durability = durability or ArcadeConfig.instance:getCollectionDurability(self.id) or 0
	self._isHasDurability = self._durability > 0

	local skillList = ArcadeConfig.instance:getCollectionPassiveSkillList(id)

	for _, skillId in ipairs(skillList) do
		if ArcadeGameHelper.isPassiveSkill(skillId) then
			self._skillSetMO:addSkillById(skillId)
		end
	end
end

function ArcadeGameCollectionMO:getSkillSetMO()
	return self._skillSetMO
end

function ArcadeGameCollectionMO:getId()
	return self.id
end

function ArcadeGameCollectionMO:addUsedTimes(value)
	self._usedTimes = math.max(0, self._usedTimes + tonumber(value))
	self._usedTimes = math.min(self._durability, self._usedTimes)
end

function ArcadeGameCollectionMO:getUsedTimes()
	return self._usedTimes
end

function ArcadeGameCollectionMO:addDurability(value)
	if self._isHasDurability then
		self._durability = math.max(0, self._durability + tonumber(value))
	end
end

function ArcadeGameCollectionMO:getDurability()
	return self._durability
end

function ArcadeGameCollectionMO:getRemainDurability()
	if self._isHasDurability then
		local useTimes = self:getUsedTimes()

		return math.max(0, self._durability - useTimes)
	end
end

function ArcadeGameCollectionMO:getType()
	return ArcadeConfig.instance:getCollectionType(self.id)
end

return ArcadeGameCollectionMO
