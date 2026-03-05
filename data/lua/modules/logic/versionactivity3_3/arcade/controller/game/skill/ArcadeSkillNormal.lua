-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/ArcadeSkillNormal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.ArcadeSkillNormal", package.seeall)

local ArcadeSkillNormal = class("ArcadeSkillNormal", ArcadeSkillBase)

function ArcadeSkillNormal:onCtor()
	self.skillConfig = ArcadeConfig.instance:getPassiveSkillCfg(self.skillId, true)
end

function ArcadeSkillNormal:onTrigger()
	for _, triggerBase in ipairs(self._triggerBaseList) do
		triggerBase:trigger(self._triggerPoint, self._context, self._ignoreTriggerPoint)
	end
end

return ArcadeSkillNormal
