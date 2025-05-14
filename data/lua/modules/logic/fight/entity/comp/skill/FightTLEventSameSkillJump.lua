module("modules.logic.fight.entity.comp.skill.FightTLEventSameSkillJump", package.seeall)

local var_0_0 = class("FightTLEventSameSkillJump")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not FightModel.instance:canParallelSkill(arg_1_1) then
		return
	end

	if not string.nilorempty(arg_1_3[1]) then
		CameraMgr.instance:getCameraRootAnimator().enabled = true

		FightController.instance:registerCallback(FightEvent.BeforePlaySameSkill, arg_1_0._onBeforePlaySameSkill, arg_1_0)

		arg_1_0._fightStepMO = arg_1_1
		arg_1_0._paramsArr = arg_1_3

		FightController.instance:dispatchEvent(FightEvent.CheckPlaySameSkill, arg_1_1)
	end
end

function var_0_0._onBeforePlaySameSkill(arg_2_0)
	if not string.nilorempty(arg_2_0._paramsArr[1]) and not arg_2_0._done then
		arg_2_0._jump_type = tonumber(arg_2_0._paramsArr[1]) or 0
		arg_2_0._audio_id = arg_2_0._fightStepMO.atkAudioId
		arg_2_0._done = true
		arg_2_0._animComp = CameraMgr.instance:getCameraRootAnimator()
		arg_2_0._animComp.enabled = false
		arg_2_0._attacker = FightHelper.getEntity(arg_2_0._fightStepMO.fromId)

		AudioEffectMgr.instance:stopAudio(arg_2_0._audio_id, 0)

		arg_2_0._curAnimState = arg_2_0._attacker.spine._curAnimState

		arg_2_0._attacker.spine:play(SpineAnimState.posture, true)

		if not string.nilorempty(arg_2_0._paramsArr[2]) then
			local var_2_0 = string.splitToNumber(arg_2_0._paramsArr[2], "#")

			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				arg_2_0._fightStepMO.cusParam_lockTimelineTypes = arg_2_0._fightStepMO.cusParam_lockTimelineTypes or {}
				arg_2_0._fightStepMO.cusParam_lockTimelineTypes[iter_2_1] = true
			end
		end

		if arg_2_0._paramsArr[3] == "1" then
			arg_2_0._fightStepMO.cus_Param_invokeSpineActTimelineEnd = true
		end

		if not string.nilorempty(arg_2_0._paramsArr[4]) then
			arg_2_0._attacker.skill:recordFilterAtkEffect(arg_2_0._paramsArr[4])
		end

		if not string.nilorempty(arg_2_0._paramsArr[5]) then
			arg_2_0._attacker.skill:recordFilterFlyEffect(arg_2_0._paramsArr[5])
		end

		arg_2_0._attacker.skill:stopCurTimelineWaitPlaySameSkill(arg_2_0._jump_type, arg_2_0._curAnimState, arg_2_0._audio_id)
	end
end

function var_0_0.reset(arg_3_0)
	arg_3_0._done = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlaySameSkill, arg_3_0._onBeforePlaySameSkill, arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	arg_4_0._animComp = nil
end

return var_0_0
