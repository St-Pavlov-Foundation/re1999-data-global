module("modules.logic.fight.system.work.FightWorkStepSkill", package.seeall)

local var_0_0 = class("FightWorkStepSkill", BaseWork)
local var_0_1 = 1
local var_0_2 = 0.01
local var_0_3 = 0
local var_0_4 = {
	[72004] = 11,
	[3124016] = 20
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._fightStepMO = arg_1_1
	arg_1_0._id = var_0_1
	var_0_1 = var_0_1 + 1
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, arg_2_0._forceEndSkillStep, arg_2_0)

	arg_2_0._attacker = FightHelper.getEntity(arg_2_0._fightStepMO.fromId)

	local var_2_0 = arg_2_0._attacker and FightSkillMgr.instance:isUniqueSkill(arg_2_0._attacker, arg_2_0._fightStepMO)
	local var_2_1 = math.min(FightModel.instance:getSpeed(), FightModel.instance:getUISpeed())
	local var_2_2 = Mathf.Clamp(var_2_1, 0.01, 1)
	local var_2_3 = (var_0_4[arg_2_0._fightStepMO.actId] or var_2_0 and 20 or 20) / var_2_2

	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, var_2_3)

	if not arg_2_0._attacker then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._skillId = arg_2_0._fightStepMO.actId

	local var_2_4 = arg_2_0._attacker:getMO()
	local var_2_5 = var_2_4 and var_2_4.skin
	local var_2_6 = FightConfig.instance:getSkinSkillTimeline(var_2_5, arg_2_0._skillId)

	if string.nilorempty(var_2_6) then
		arg_2_0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, arg_2_0._onBeforeDestroyEntity, arg_2_0)

	if FightSkillMgr.instance:isEntityPlayingTimeline(arg_2_0._attacker.id) then
		TaskDispatcher.runRepeat(arg_2_0._checkNoSkillPlaying, arg_2_0, 0.01)
	else
		arg_2_0:_canPlaySkill()
	end
end

function var_0_0._checkNoSkillPlaying(arg_3_0)
	if not FightSkillMgr.instance:isEntityPlayingTimeline(arg_3_0._attacker.id) then
		TaskDispatcher.cancelTask(arg_3_0._checkNoSkillPlaying, arg_3_0)
		arg_3_0:_canPlaySkill()
	end
end

function var_0_0._canPlaySkill(arg_4_0)
	var_0_0.needWaitBeforeSkill = nil

	FightController.instance:dispatchEvent(FightEvent.BeforeSkillDialog, arg_4_0._skillId)

	if var_0_0.needWaitBeforeSkill then
		TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
		FightController.instance:registerCallback(FightEvent.DialogContinueSkill, arg_4_0._canPlaySkill2, arg_4_0)
	else
		arg_4_0:_canPlaySkill2()
	end
end

function var_0_0._canPlaySkill2(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, arg_5_0._canPlaySkill2, arg_5_0)

	if FightModel.instance:getVersion() >= 1 then
		if FightHelper.isPlayerCardSkill(arg_5_0._fightStepMO) then
			if arg_5_0._fightStepMO.cardIndex - 1 > FightPlayCardModel.instance:getCurIndex() then
				FightController.instance:dispatchEvent(FightEvent.InvalidPreUsedCard, arg_5_0._fightStepMO.cardIndex)
				TaskDispatcher.runDelay(arg_5_0._delayAfterDissolveCard, arg_5_0, 1 / FightModel.instance:getUISpeed())

				return
			end

			FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, arg_5_0._attacker, arg_5_0._skillId, arg_5_0._fightStepMO)
		end

		arg_5_0:_playSkill(arg_5_0._skillId)
	else
		local var_5_0 = not arg_5_0._fightStepMO.editorPlaySkill
		local var_5_1 = arg_5_0._attacker:isMySide() and FightCardModel.instance:isActiveSkill(arg_5_0._fightStepMO.fromId, arg_5_0._skillId)
		local var_5_2 = FightPlayCardModel.instance:getClientLeftSkillOpList()
		local var_5_3 = var_5_2 and var_5_2[#var_5_2]
		local var_5_4 = var_5_3 and arg_5_0._skillId == var_5_3.skillId

		if var_5_0 and (var_5_1 or var_5_4) then
			local var_5_5 = var_0_3 + var_0_2 - Time.realtimeSinceStartup

			if var_5_5 > 0 then
				TaskDispatcher.runDelay(arg_5_0._toPlaySkill, arg_5_0, var_5_5)
			else
				arg_5_0:_toPlaySkill()
			end
		else
			arg_5_0:_playSkill(arg_5_0._skillId)
		end
	end
end

function var_0_0._delayAfterDissolveCard(arg_6_0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, arg_6_0._attacker, arg_6_0._skillId, arg_6_0._fightStepMO)
	arg_6_0:_playSkill(arg_6_0._skillId)
end

function var_0_0._delayPlaySkill(arg_7_0)
	arg_7_0:_playSkill(arg_7_0._skillId)
end

function var_0_0._toPlaySkill(arg_8_0)
	FightController.instance:registerCallback(FightEvent.ToPlaySkill, arg_8_0._playSkill, arg_8_0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, arg_8_0._attacker, arg_8_0._skillId, arg_8_0._fightStepMO)
end

function var_0_0._playSkill(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0._fightStepMO.actId then
		arg_9_0:onDone(true)

		return
	end

	if arg_9_0._fightStepMO.fromId == "0" or arg_9_0._attacker then
		FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, arg_9_0._playSkill, arg_9_0)
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_9_0._onSkillEnd, arg_9_0, LuaEventSystem.Low)
		arg_9_0._attacker.skill:playSkill(arg_9_0._skillId, arg_9_0._fightStepMO)
	else
		logError("attacker entity not exist, can't play skill " .. arg_9_0._skillId)
		arg_9_0:onDone(true)
	end
end

function var_0_0._onSkillEnd(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 == arg_10_0._fightStepMO then
		arg_10_0:_removeEvents()

		var_0_3 = Time.realtimeSinceStartup
		var_0_0.needStopSkillEnd = nil

		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillNP)
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillP)

		if var_0_0.needStopSkillEnd then
			TaskDispatcher.cancelTask(arg_10_0._delayDone, arg_10_0)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, arg_10_0._onFightDialogEnd, arg_10_0)
		elseif FightModel.instance:getVersion() >= 1 then
			if FightHelper.isPlayerCardSkill(arg_10_3) then
				TaskDispatcher.runDelay(arg_10_0._delayAfterSkillEnd, arg_10_0, 0.3 / FightModel.instance:getUISpeed())
			else
				arg_10_0:onDone(true)
			end
		else
			arg_10_0:onDone(true)
		end
	end
end

function var_0_0._delayAfterSkillEnd(arg_11_0)
	arg_11_0:onDone(true)
end

function var_0_0._onFightDialogEnd(arg_12_0)
	arg_12_0:onDone(true)
end

function var_0_0._forceEndSkillStep(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0._fightStepMO then
		arg_13_0:_removeEvents()
		arg_13_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_14_0)
	logError("skill play timeout, skillId = " .. arg_14_0._skillId)
	arg_14_0:_removeEvents()
	FightController.instance:dispatchEvent(FightEvent.FightWorkStepSkillTimeout, arg_14_0._fightStepMO)
end

function var_0_0._removeEvents(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayAfterDissolveCard, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayPlaySkill, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayAfterSkillEnd, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayDone, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._toPlaySkill, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._checkNoSkillPlaying, arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, arg_15_0._playSkill, arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_15_0._onSkillEnd, arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, arg_15_0._forceEndSkillStep, arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, arg_15_0._canPlaySkill2, arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_15_0._onFightDialogEnd, arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, arg_15_0._onBeforeDestroyEntity, arg_15_0)
end

function var_0_0._onBeforeDestroyEntity(arg_16_0, arg_16_1)
	if arg_16_0._attacker and arg_16_0._attacker.id == arg_16_1.id then
		arg_16_0:onDone(true)
	end
end

function var_0_0.onStop(arg_17_0)
	var_0_0.super.onStop(arg_17_0)

	if arg_17_0._attacker and arg_17_0._attacker.skill then
		arg_17_0._attacker.skill:stopSkill()
	end
end

function var_0_0.onResume(arg_18_0)
	logError("skill step can't resume")
end

function var_0_0.clearWork(arg_19_0)
	arg_19_0:_removeEvents()
end

return var_0_0
