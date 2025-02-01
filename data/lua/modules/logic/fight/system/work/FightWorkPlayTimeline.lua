module("modules.logic.fight.system.work.FightWorkPlayTimeline", package.seeall)

slot0 = class("FightWorkPlayTimeline", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._entity = slot1
	slot0._entityId = slot1.id
	slot0._timeline = slot2
end

function slot0.onStart(slot0, slot1)
	slot0:_playTimeline()
end

function slot0._playTimeline(slot0)
	if slot0._entity.skill then
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0, LuaEventSystem.Low)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 30)
		slot0._entity.skill:playTimeline(slot0._timeline, {
			actId = 0,
			actEffectMOs = {
				{
					targetId = slot0._entityId
				}
			},
			actEffect = {},
			fromId = slot0._entityId,
			toId = slot0._entityId,
			actType = FightEnum.ActType.SKILL,
			stepUid = FightTLEventEntityVisible.latestStepUid or 0
		})
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onSkillPlayFinish(slot0, slot1)
	if slot1.id == slot0._entityId then
		slot0:_delayDone()
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

return slot0
