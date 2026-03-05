-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitWeaponUsedTimesFix.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitWeaponUsedTimesFix", package.seeall)

local ArcadeSkillHitWeaponUsedTimesFix = class("ArcadeSkillHitWeaponUsedTimesFix", ArcadeSkillHitBase)

function ArcadeSkillHitWeaponUsedTimesFix:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._useTimes = tonumber(params[2])
	self._weaponUIdList = {}
end

function ArcadeSkillHitWeaponUsedTimesFix:onHit()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	self:clearList(self._weaponUIdList)

	if characterMO then
		characterMO:findUseWeaponUid(self._weaponUIdList)
	end

	if self._weaponUIdList and #self._weaponUIdList > 0 then
		self:addHiter(characterMO)

		for _, uid in ipairs(self._weaponUIdList) do
			ArcadeGameController.instance:tryUseCollection(uid, -self._useTimes)
		end
	end
end

function ArcadeSkillHitWeaponUsedTimesFix:onHitPrintLog()
	if self._weaponUIdList and #self._weaponUIdList > 0 then
		logNormal(string.format("%s ==> 修正的武器已使用次数:%s uids=>%s", self:getLogPrefixStr(), self._useTimes, table.concat(self._weaponUIdList, ",")))
	end
end

return ArcadeSkillHitWeaponUsedTimesFix
