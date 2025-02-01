module("modules.logic.fight.system.work.trigger.FightWorkTriggerTimeline", package.seeall)

slot0 = class("FightWorkTriggerTimeline", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
end

function slot0.onStart(slot0)
	slot0._config = lua_trigger_action.configDict[slot0._actEffectMO.effectNum]
	slot1 = tonumber(slot0._config.param1)
	slot2 = FightHelper.getEnemyEntityByMonsterId(slot1)

	if slot1 == 0 then
		slot2 = FightHelper.getEntity(FightEntityScene.MySideId)
	end

	if slot2 and slot2.skill then
		slot0._entityId = slot2.id

		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 20)
		slot2.skill:playTimeline(slot0._config.param2, {
			actId = 0,
			stepUid = 0,
			actEffectMOs = {
				{
					targetId = slot0._entityId
				}
			},
			actEffect = {},
			fromId = slot0._entityId,
			toId = slot0._fightStepMO.toId,
			actType = FightEnum.ActType.SKILL
		})

		return
	end

	slot0:_delayDone()
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
