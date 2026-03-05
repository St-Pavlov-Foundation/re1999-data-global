-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillTriggerBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillTriggerBase", package.seeall)

local ArcadeSkillTriggerBase = class("ArcadeSkillTriggerBase", ArcadeSkillClass)

function ArcadeSkillTriggerBase:ctor(condBase, hitBase, triggerPoint)
	ArcadeSkillTriggerBase.super.ctor(self)

	self._condBase = condBase
	self._hitBase = hitBase
	self._triggerPoint = triggerPoint
end

function ArcadeSkillTriggerBase:isCondSuccess(context)
	if self._hitBase:isReachMaxLimit() then
		return false
	end

	if self._condBase and self._condBase:isCondSuccess(context) then
		return true
	end

	return false
end

function ArcadeSkillTriggerBase:setSkillBase(skillBase)
	self._skillBase = skillBase

	if self._condBase then
		self._condBase:setSkillBase(skillBase)
	end

	if self._hitBase then
		self._hitBase:setSkillBase(skillBase)
	end
end

function ArcadeSkillTriggerBase:getCondBase()
	return self._condBase
end

function ArcadeSkillTriggerBase:getHitBase()
	return self._hitBase
end

function ArcadeSkillTriggerBase:getTriggerPoint()
	return self._triggerPoint
end

function ArcadeSkillTriggerBase:trigger(triggerPoint, context, ignoreTriggerPoint)
	self._context = context

	if (self._triggerPoint == triggerPoint or ignoreTriggerPoint == true) and self:isCondSuccess(context) then
		self:tryCallFunc(self.onTrigger)
	end
end

function ArcadeSkillTriggerBase:onTrigger()
	self._hitBase:hit(self._context)
end

return ArcadeSkillTriggerBase
