-- chunkname: @modules/logic/fight/system/work/FightWorkPlayTimeline.lua

module("modules.logic.fight.system.work.FightWorkPlayTimeline", package.seeall)

local FightWorkPlayTimeline = class("FightWorkPlayTimeline", BaseWork)

function FightWorkPlayTimeline:ctor(entity, timeline, toId)
	self._entity = entity
	self._entityId = entity.id
	self._timeline = timeline
	self._toId = toId
end

function FightWorkPlayTimeline:onStart(context)
	if self._entity.IS_REMOVED then
		self:onDone(true)
	else
		self:_playTimeline()
	end
end

function FightWorkPlayTimeline:_playTimeline()
	if string.nilorempty(self._timeline) then
		self:onDone(true)

		return
	end

	if self._entity.skill then
		local temp_data = {
			actId = 0,
			actEffect = {
				{
					targetId = self._entityId
				}
			},
			fromId = self._entityId,
			toId = self._toId or self._entityId,
			actType = FightEnum.ActType.SKILL,
			stepUid = FightTLEventEntityVisible.latestStepUid or 0
		}

		FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity, self)
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self, LuaEventSystem.Low)
		TaskDispatcher.runDelay(self._delayDone, self, 30)
		self._entity.skill:playTimeline(self._timeline, temp_data)
	else
		self:onDone(true)
	end
end

function FightWorkPlayTimeline:_onBeforeDestroyEntity(entity)
	if entity == self._entity then
		self:onDone(true)
	end
end

function FightWorkPlayTimeline:_delayDone()
	self:onDone(true)
end

function FightWorkPlayTimeline:_onSkillPlayFinish(entity)
	if entity.id == self._entityId then
		self:_delayDone()
	end
end

function FightWorkPlayTimeline:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity, self)
end

return FightWorkPlayTimeline
