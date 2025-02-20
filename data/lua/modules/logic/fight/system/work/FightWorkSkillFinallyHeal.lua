module("modules.logic.fight.system.work.FightWorkSkillFinallyHeal", package.seeall)

slot0 = class("FightWorkSkillFinallyHeal", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
	slot0._actEffectMOs = {}
end

function slot0.addActEffectMO(slot0, slot1)
	table.insert(slot0._actEffectMOs, slot1)
end

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._fightStepMO.fromId) then
		slot0:onDone(true)

		return
	end

	if string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot1:getMO() and slot3.skin, slot0._fightStepMO.actId)) then
		slot0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 20 / FightModel.instance:getSpeed())
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)
	FightController.instance:registerCallback(FightEvent.OnTimelineHeal, slot0._onTimelineHeal, slot0)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onSkillEnd(slot0, slot1, slot2, slot3)
	if slot3 ~= slot0._fightStepMO then
		return
	end

	slot0:_removeEvents()

	for slot7, slot8 in ipairs(slot0._actEffectMOs) do
		if FightHelper.getEntity(slot8.targetId) and not slot9.isDead then
			FightDataHelper.playEffectData(slot8)

			if slot8.effectType == FightEnum.EffectType.HEAL then
				FightFloatMgr.instance:float(slot9.id, FightEnum.FloatType.heal, slot8.effectNum)
			elseif slot8.effectType == FightEnum.EffectType.HEALCRIT then
				FightFloatMgr.instance:float(slot9.id, FightEnum.FloatType.crit_heal, slot8.effectNum)
			end

			if slot9.nameUI then
				slot9.nameUI:addHp(slot8.effectNum)

				if not FightSkillMgr.instance:isPlayingAnyTimeline() then
					slot9.nameUI:setActive(true)
				end
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot9, slot8.effectNum)
		end
	end

	slot0:onDone(true)
end

function slot0._onTimelineHeal(slot0, slot1)
	tabletool.removeValue(slot0._actEffectMOs, slot1)
end

function slot0._removeEvents(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnTimelineHeal, slot0._onTimelineHeal, slot0)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0:_removeEvents()
end

return slot0
