-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillBase", package.seeall)

local ArcadeSkillBase = class("ArcadeSkillBase", ArcadeSkillClass)

function ArcadeSkillBase:ctor(skillId)
	ArcadeSkillBase.super.ctor(self)

	self.skillId = skillId
	self._triggerBaseList = {}
	self._skillBase = self
	self.isActive = true

	self:tryCallFunc(self.onCtor)
end

function ArcadeSkillBase:trigger(triggerPoint, context, ignoreTriggerPoint)
	self._context = context
	self._triggerPoint = triggerPoint
	self._ignoreTriggerPoint = ignoreTriggerPoint

	self:tryCallFunc(self.onTrigger)
end

function ArcadeSkillBase:getTriggerList()
	return self._triggerBaseList
end

function ArcadeSkillBase:addTriggerBase(triggerBase)
	if triggerBase then
		table.insert(self._triggerBaseList, triggerBase)
		triggerBase:setSkillBase(self)
	end
end

function ArcadeSkillBase:setSkillBase(skillBase)
	return
end

function ArcadeSkillBase:getSkillConfig()
	return self.skillConfig
end

function ArcadeSkillBase:getSkillId()
	return self.skillId
end

function ArcadeSkillBase:onCtor()
	return
end

function ArcadeSkillBase:onTrigger()
	return
end

return ArcadeSkillBase
