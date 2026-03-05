-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameSkillSetMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameSkillSetMO", package.seeall)

local ArcadeGameSkillSetMO = class("ArcadeGameSkillSetMO")

function ArcadeGameSkillSetMO:ctor(id, unitMO)
	self.id = id or 0
	self.unitMO = unitMO
	self._skillDict = {}
	self._skillList = {}
	self._opIndex = 0
end

function ArcadeGameSkillSetMO:getSkillList()
	if self._isRemoveOp then
		self._isRemoveOp = false

		local skillList = self._skillList
		local skill

		for i = #skillList, 1, -1 do
			skill = skillList[i]

			if skill and skill.isActive == false then
				table.remove(skillList, i)
			end
		end
	end

	return self._skillList
end

function ArcadeGameSkillSetMO:getSkillIdList()
	local result = {}

	for skillId, _ in pairs(self._skillDict) do
		result[#result + 1] = skillId
	end

	return result
end

function ArcadeGameSkillSetMO:getSkillById(skillId)
	return self._skillDict[skillId]
end

function ArcadeGameSkillSetMO:addSkillById(skillId)
	if not self._skillDict[skillId] then
		local skill = ArcadeSkillFactory.instance:createSkillById(skillId, self.unitMO)

		if skill then
			self._skillDict[skillId] = skill

			table.insert(self._skillList, skill)

			self._opIndex = self._opIndex + 1
		end
	end
end

function ArcadeGameSkillSetMO:removeSkillById(skillId)
	if self._skillDict[skillId] then
		local skill = self._skillDict[skillId]

		skill.isActive = false
		self._skillDict[skillId] = nil

		tabletool.removeValue(self._skillList, skill)

		self._isRemoveOp = true
		self._opIndex = self._opIndex + 1
	end
end

function ArcadeGameSkillSetMO:getOpIdx()
	return self._opIndex
end

return ArcadeGameSkillSetMO
