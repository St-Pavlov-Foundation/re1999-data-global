module("modules.logic.fight.system.work.FightWorkStepSkill", package.seeall)

slot0 = class("FightWorkStepSkill", BaseWork)
slot1 = 1
slot2 = 0.01
slot3 = 0
slot4 = {
	[72004.0] = 11,
	[3124016.0] = 20
}

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
	slot0._id = uv0
	uv0 = uv0 + 1
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)

	slot0._attacker = FightHelper.getEntity(slot0._fightStepMO.fromId)

	TaskDispatcher.runDelay(slot0._delayDone, slot0, (uv0[slot0._fightStepMO.actId] or slot0._attacker and FightSkillMgr.instance:isUniqueSkill(slot0._attacker, slot0._fightStepMO) and 20 or 20) / Mathf.Clamp(math.min(FightModel.instance:getSpeed(), FightModel.instance:getUISpeed()), 0.01, 1))

	if not slot0._attacker then
		slot0:onDone(true)

		return
	end

	slot0._skillId = slot0._fightStepMO.actId

	if string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot0._attacker:getMO() and slot4.skin, slot0._skillId)) then
		slot0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity, slot0)

	if FightSkillMgr.instance:isEntityPlayingTimeline(slot0._attacker.id) then
		TaskDispatcher.runRepeat(slot0._checkNoSkillPlaying, slot0, 0.01)
	else
		slot0:_canPlaySkill()
	end
end

function slot0._checkNoSkillPlaying(slot0)
	if not FightSkillMgr.instance:isEntityPlayingTimeline(slot0._attacker.id) then
		TaskDispatcher.cancelTask(slot0._checkNoSkillPlaying, slot0)
		slot0:_canPlaySkill()
	end
end

function slot0._canPlaySkill(slot0)
	uv0.needWaitBeforeSkill = nil

	FightController.instance:dispatchEvent(FightEvent.BeforeSkillDialog, slot0._skillId)

	if uv0.needWaitBeforeSkill then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		FightController.instance:registerCallback(FightEvent.DialogContinueSkill, slot0._canPlaySkill2, slot0)
	else
		slot0:_canPlaySkill2()
	end
end

function slot0._canPlaySkill2(slot0)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, slot0._canPlaySkill2, slot0)

	if FightModel.instance:getVersion() >= 1 then
		if FightHelper.isPlayerCardSkill(slot0._fightStepMO) then
			if FightPlayCardModel.instance:getCurIndex() < slot0._fightStepMO.cardIndex - 1 then
				FightController.instance:dispatchEvent(FightEvent.InvalidPreUsedCard, slot0._fightStepMO.cardIndex)
				TaskDispatcher.runDelay(slot0._delayAfterDissolveCard, slot0, 1 / FightModel.instance:getUISpeed())

				return
			end

			FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, slot0._attacker, slot0._skillId, slot0._fightStepMO)
		end

		slot0:_playSkill(slot0._skillId)
	else
		slot5 = FightPlayCardModel.instance:getClientLeftSkillOpList() and slot4[#slot4]

		if not slot0._fightStepMO.editorPlaySkill and (slot0._attacker:isMySide() and FightCardModel.instance:isActiveSkill(slot0._fightStepMO.fromId, slot0._skillId) or slot5 and slot0._skillId == slot5.skillId) then
			if uv0 + uv1 - Time.realtimeSinceStartup > 0 then
				TaskDispatcher.runDelay(slot0._toPlaySkill, slot0, slot7)
			else
				slot0:_toPlaySkill()
			end
		else
			slot0:_playSkill(slot0._skillId)
		end
	end
end

function slot0._delayAfterDissolveCard(slot0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, slot0._attacker, slot0._skillId, slot0._fightStepMO)
	slot0:_playSkill(slot0._skillId)
end

function slot0._delayPlaySkill(slot0)
	slot0:_playSkill(slot0._skillId)
end

function slot0._toPlaySkill(slot0)
	FightController.instance:registerCallback(FightEvent.ToPlaySkill, slot0._playSkill, slot0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, slot0._attacker, slot0._skillId, slot0._fightStepMO)
end

function slot0._playSkill(slot0, slot1)
	if slot1 ~= slot0._fightStepMO.actId then
		slot0:onDone(true)

		return
	end

	if slot0._fightStepMO.fromId == "0" or slot0._attacker then
		FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, slot0._playSkill, slot0)
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0, LuaEventSystem.Low)
		slot0._attacker.skill:playSkill(slot0._skillId, slot0._fightStepMO)
	else
		logError("attacker entity not exist, can't play skill " .. slot0._skillId)
		slot0:onDone(true)
	end
end

function slot0._onSkillEnd(slot0, slot1, slot2, slot3)
	if slot3 == slot0._fightStepMO then
		slot0:_removeEvents()

		uv0 = Time.realtimeSinceStartup
		uv1.needStopSkillEnd = nil

		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillNP)
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillP)

		if uv1.needStopSkillEnd then
			TaskDispatcher.cancelTask(slot0._delayDone, slot0)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
		elseif FightModel.instance:getVersion() >= 1 then
			if FightHelper.isPlayerCardSkill(slot3) then
				TaskDispatcher.runDelay(slot0._delayAfterSkillEnd, slot0, 0.3 / FightModel.instance:getUISpeed())
			else
				slot0:onDone(true)
			end
		else
			slot0:onDone(true)
		end
	end
end

function slot0._delayAfterSkillEnd(slot0)
	slot0:onDone(true)
end

function slot0._onFightDialogEnd(slot0)
	slot0:onDone(true)
end

function slot0._forceEndSkillStep(slot0, slot1)
	if slot1 == slot0._fightStepMO then
		slot0:_removeEvents()
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	logError("skill play timeout, skillId = " .. slot0._skillId)
	slot0:_removeEvents()
	FightController.instance:dispatchEvent(FightEvent.FightWorkStepSkillTimeout, slot0._fightStepMO)
end

function slot0._removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterDissolveCard, slot0)
	TaskDispatcher.cancelTask(slot0._delayPlaySkill, slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterSkillEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._toPlaySkill, slot0)
	TaskDispatcher.cancelTask(slot0._checkNoSkillPlaying, slot0)
	FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, slot0._playSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, slot0._canPlaySkill2, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity, slot0)
end

function slot0._onBeforeDestroyEntity(slot0, slot1)
	if slot0._attacker and slot0._attacker.id == slot1.id then
		slot0:onDone(true)
	end
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)

	if slot0._attacker and slot0._attacker.skill then
		slot0._attacker.skill:stopSkill()
	end
end

function slot0.onResume(slot0)
	logError("skill step can't resume")
end

function slot0.clearWork(slot0)
	slot0:_removeEvents()
end

return slot0
