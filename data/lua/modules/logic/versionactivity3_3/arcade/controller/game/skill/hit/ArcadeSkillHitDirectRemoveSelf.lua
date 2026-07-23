-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDirectRemoveSelf.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDirectRemoveSelf", package.seeall)

local ArcadeSkillHitDirectRemoveSelf = class("ArcadeSkillHitDirectRemoveSelf", ArcadeSkillHitBase)

function ArcadeSkillHitDirectRemoveSelf:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._actionShowId = tonumber(params[2])
end

function ArcadeSkillHitDirectRemoveSelf:onHit()
	local target = self._context and self._context.target

	if not target then
		return
	end

	ArcadeGameController.instance:directRemoveEntity(target, self._actionShowId)
end

function ArcadeSkillHitDirectRemoveSelf:onHitPrintLog()
	local target = self._context and self._context.target

	if not target then
		return
	end

	logNormal(string.format("%s ==> 直接移除实体【%s-%s-%s】", self:getLogPrefixStr(), target:getEntityType(), target.id, target:getUid()))
end

return ArcadeSkillHitDirectRemoveSelf
