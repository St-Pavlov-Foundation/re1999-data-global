-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/ArcadeSkillNormal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.ArcadeSkillNormal", package.seeall)

local ArcadeSkillNormal = class("ArcadeSkillNormal", ArcadeSkillBase)

function ArcadeSkillNormal:onCtor()
	self.skillConfig = ArcadeConfig.instance:getPassiveSkillCfg(self.skillId, true)
end

function ArcadeSkillNormal:onTrigger(params)
	local triggerPoint = params and params.triggerPoint

	if not triggerPoint then
		return
	end

	local context = params.context or {}
	local ignoreTriggerPoint = params.ignoreTriggerPoint

	for _, triggerBase in ipairs(self._triggerBaseList) do
		triggerBase:trigger(triggerPoint, context, ignoreTriggerPoint)
	end
end

function ArcadeSkillNormal:getTriggerOrder()
	return self.skillConfig and self.skillConfig.triggerOrder or 0
end

return ArcadeSkillNormal
