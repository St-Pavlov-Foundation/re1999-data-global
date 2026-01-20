-- chunkname: @modules/logic/fight/entity/comp/FightEntityVisibleComp.lua

module("modules.logic.fight.entity.comp.FightEntityVisibleComp", package.seeall)

local FightEntityVisibleComp = class("FightEntityVisibleComp", LuaCompBase)

function FightEntityVisibleComp:ctor(entity)
	self.entity = entity
	self._hideByEntity = nil
	self._hideBySkill = nil

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.SetEntityVisibleByTimeline, self._setEntityVisibleByTimeline, self)
end

function FightEntityVisibleComp:addEventListeners()
	return
end

function FightEntityVisibleComp:beforeDestroy()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.SetEntityVisibleByTimeline, self._setEntityVisibleByTimeline, self)
end

function FightEntityVisibleComp:_onSkillPlayStart(entity, skillId, fightStepData)
	if skillId == FightEnum.AppearTimelineSkillId then
		return
	end

	local relative = FightHelper.getRelativeEntityIdDict(fightStepData)

	if relative[self.entity.id] then
		self.entity:setAlpha(1, 0)

		self._hideByEntity = nil
		self._hideBySkill = nil
	end
end

function FightEntityVisibleComp:_onSkillPlayFinish(entity, skillId, fightStepData)
	if entity.skill and entity.skill:sameSkillPlaying() then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityFootEffectVisible, self.entity.id, true)

	if FightWorkStepChangeHero.playingChangeHero or FightWorkChangeHero.playingChangeHero then
		return
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		self.entity:setAlpha(1, 0)

		self._hideByEntity = nil
		self._hideBySkill = nil
	elseif self._hideByEntity and self._hideByEntity == entity.id and self._hideBySkill == skillId then
		self.entity:setAlpha(1, 0)

		self._hideByEntity = nil
		self._hideBySkill = nil
	elseif fightStepData.stepUid == FightTLEventEntityVisible.latestStepUid then
		self.entity:setAlpha(1, 0)

		self._hideByEntity = nil
		self._hideBySkill = nil
	end
end

function FightEntityVisibleComp:_setEntityVisibleByTimeline(entity, fightStepData, isVisible, transitionTime)
	if self.entity.id ~= entity.id then
		return
	end

	if isVisible then
		self.entity:setAlpha(1, transitionTime)

		self._hideByEntity = nil
		self._hideBySkill = nil
	else
		self.entity:setAlpha(0, transitionTime)

		self._hideByEntity = entity.id
		self._hideBySkill = fightStepData.actId
	end

	if not isVisible then
		FightFloatMgr.instance:hideEntityEquipFloat(entity.id)
	end

	if not FightCardDataHelper.isBigSkill(fightStepData.actId) then
		FightController.instance:dispatchEvent(FightEvent.SetEntityFootEffectVisible, entity.id, isVisible)
	end
end

return FightEntityVisibleComp
