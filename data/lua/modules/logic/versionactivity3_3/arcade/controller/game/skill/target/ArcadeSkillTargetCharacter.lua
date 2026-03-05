-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetCharacter.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetCharacter", package.seeall)

local ArcadeSkillTargetCharacter = class("ArcadeSkillTargetCharacter", ArcadeSkillTargetBase)

function ArcadeSkillTargetCharacter:onFindTarget()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		self:addTarget(characterMO)
	end
end

function ArcadeSkillTargetCharacter:addTarget(target)
	if not target or target:getIsDead() then
		return
	end

	local uid = target:getUid()

	if not self._targetIdDict[uid] then
		table.insert(self._targetList, target)

		self._targetIdDict[uid] = true
		self._isAddNewTarget = true
	end
end

return ArcadeSkillTargetCharacter
