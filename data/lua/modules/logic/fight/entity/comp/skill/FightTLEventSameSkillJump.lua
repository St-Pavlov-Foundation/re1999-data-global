module("modules.logic.fight.entity.comp.skill.FightTLEventSameSkillJump", package.seeall)

slot0 = class("FightTLEventSameSkillJump")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not FightModel.instance:canParallelSkill(slot1) then
		return
	end

	if not string.nilorempty(slot3[1]) then
		CameraMgr.instance:getCameraRootAnimator().enabled = true

		FightController.instance:registerCallback(FightEvent.BeforePlaySameSkill, slot0._onBeforePlaySameSkill, slot0)

		slot0._fightStepMO = slot1
		slot0._paramsArr = slot3

		FightController.instance:dispatchEvent(FightEvent.CheckPlaySameSkill, slot1)
	end
end

function slot0._onBeforePlaySameSkill(slot0)
	if not string.nilorempty(slot0._paramsArr[1]) and not slot0._done then
		slot0._jump_type = tonumber(slot0._paramsArr[1]) or 0
		slot0._audio_id = slot0._fightStepMO.atkAudioId
		slot0._done = true
		slot0._animComp = CameraMgr.instance:getCameraRootAnimator()
		slot0._animComp.enabled = false
		slot0._attacker = FightHelper.getEntity(slot0._fightStepMO.fromId)

		AudioEffectMgr.instance:stopAudio(slot0._audio_id, 0)

		slot0._curAnimState = slot0._attacker.spine._curAnimState

		slot0._attacker.spine:play(SpineAnimState.posture, true)

		if not string.nilorempty(slot0._paramsArr[2]) then
			for slot5, slot6 in ipairs(string.splitToNumber(slot0._paramsArr[2], "#")) do
				slot0._fightStepMO.cusParam_lockTimelineTypes = slot0._fightStepMO.cusParam_lockTimelineTypes or {}
				slot0._fightStepMO.cusParam_lockTimelineTypes[slot6] = true
			end
		end

		if slot0._paramsArr[3] == "1" then
			slot0._fightStepMO.cus_Param_invokeSpineActTimelineEnd = true
		end

		if not string.nilorempty(slot0._paramsArr[4]) then
			slot0._attacker.skill:recordFilterAtkEffect(slot0._paramsArr[4])
		end

		if not string.nilorempty(slot0._paramsArr[5]) then
			slot0._attacker.skill:recordFilterFlyEffect(slot0._paramsArr[5])
		end

		slot0._attacker.skill:stopCurTimelineWaitPlaySameSkill(slot0._jump_type, slot0._curAnimState, slot0._audio_id)
	end
end

function slot0.reset(slot0)
	slot0._done = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlaySameSkill, slot0._onBeforePlaySameSkill, slot0)
end

function slot0.dispose(slot0)
	slot0._animComp = nil
end

return slot0
