-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondHitTargetHaveBuff.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondHitTargetHaveBuff", package.seeall)

local ArcadeSkillCondHitTargetHaveBuff = class("ArcadeSkillCondHitTargetHaveBuff", ArcadeSkillCondInSpecifyFloor)

function ArcadeSkillCondHitTargetHaveBuff:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._specBuffId = tonumber(params[2])
end

function ArcadeSkillCondHitTargetHaveBuff:onIsCondSuccess()
	local hitterList = self._context and self._context.hiterList

	if not self._specBuffId or not hitterList then
		return
	end

	for _, mo in ipairs(hitterList) do
		local buffSetMO = mo:getBuffSetMO()
		local buff = buffSetMO:getBuffById(self._specBuffId)

		if buff then
			return true
		end
	end

	return false
end

return ArcadeSkillCondHitTargetHaveBuff
