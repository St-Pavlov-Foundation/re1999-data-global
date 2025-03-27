module("modules.logic.fight.entity.comp.skill.FightTLEventUIVisible", package.seeall)

slot0 = class("FightTLEventUIVisible")
slot1 = nil
slot2 = {
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function slot0.resetLatestStepUid()
	uv0 = nil
end

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if uv0 and slot1.stepUid < uv0 then
		return
	end

	uv0 = slot1.stepUid
	slot0._fightStepMO = slot1
	slot0._isShowUI = slot3[1] == "1" and true or false
	slot0._isShowFloat = slot3[2] == "1" and true or false
	slot0._isShowNameUI = slot3[3] == "1" and true or false
	slot0._showNameUITarget = slot3[4] and tonumber(slot3[4]) or 0
	slot4 = FightHelper.getEntity(slot1.fromId)
	slot5 = FightHelper.getEntity(slot1.toId)
	slot0._entitys = nil

	if slot0._showNameUITarget == 0 then
		slot0._entitys = FightHelper.getAllEntitys()
	elseif slot0._showNameUITarget == 1 then
		slot0._entitys = {}

		table.insert(slot0._entitys, slot4)
	elseif slot0._showNameUITarget == 2 then
		slot0._entitys = FightHelper.getSkillTargetEntitys(slot1, uv1)
	elseif slot0._showNameUITarget == 3 then
		if slot4 then
			slot0._entitys = FightHelper.getSideEntitys(slot4:getSide(), true)
		end
	elseif slot0._showNameUITarget == 4 and slot5 then
		slot0._entitys = FightHelper.getSideEntitys(slot5:getSide(), true)
	end

	slot0:_setShowUI()
	TaskDispatcher.runRepeat(slot0._setShowUI, slot0, 0.5)
	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._onDoneThis, slot0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, slot0._onDoneThis, slot0)
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_removeEvent()
end

function slot0._setShowUI(slot0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, slot0._isShowUI)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, slot0._isShowFloat)

	if slot0._entitys then
		for slot4, slot5 in ipairs(slot0._entitys) do
			FightController.instance:dispatchEvent(FightEvent.SetNameUIVisibleByTimeline, slot5, slot0._fightStepMO, slot0._isShowNameUI)
		end
	end
end

function slot0._onDoneThis(slot0, slot1)
	if slot1 == slot0._fightStepMO then
		slot0:_removeEvent()
	end
end

function slot0.onSkillEnd(slot0)
	slot0._entitys = nil

	slot0:_removeEvent()
end

function slot0.reset(slot0)
	slot0._entitys = nil

	slot0:_removeEvent()
end

function slot0.dispose(slot0)
	slot0._entitys = nil

	slot0:_removeEvent()
end

function slot0._removeEvent(slot0)
	TaskDispatcher.cancelTask(slot0._setShowUI, slot0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._onDoneThis, slot0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, slot0._onDoneThis, slot0)
end

return slot0
