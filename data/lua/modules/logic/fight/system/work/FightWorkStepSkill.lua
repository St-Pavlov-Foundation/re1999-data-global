module("modules.logic.fight.system.work.FightWorkStepSkill", package.seeall)

local var_0_0 = class("FightWorkStepSkill", BaseWork)
local var_0_1 = 1
local var_0_2 = 0.01
local var_0_3 = 0

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._id = var_0_1
	var_0_1 = var_0_1 + 1
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, arg_2_0._forceEndSkillStep, arg_2_0)

	arg_2_0._attacker = FightHelper.getEntity(arg_2_0.fightStepData.fromId)

	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 20)

	if not arg_2_0._attacker then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._skillId = arg_2_0.fightStepData.actId

	local var_2_0 = arg_2_0._attacker:getMO()
	local var_2_1 = var_2_0 and var_2_0.skin
	local var_2_2 = FightConfig.instance:getSkinSkillTimeline(var_2_1, arg_2_0._skillId)

	if string.nilorempty(var_2_2) then
		arg_2_0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, arg_2_0._onBeforeDestroyEntity, arg_2_0)
	arg_2_0:_canPlaySkill()
end

function var_0_0._canPlaySkill(arg_3_0)
	var_0_0.needWaitBeforeSkill = nil

	FightController.instance:dispatchEvent(FightEvent.BeforeSkillDialog, arg_3_0._skillId)

	if var_0_0.needWaitBeforeSkill then
		TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
		FightController.instance:registerCallback(FightEvent.DialogContinueSkill, arg_3_0._canPlaySkill2, arg_3_0)
	else
		arg_3_0:_canPlaySkill2()
	end
end

function var_0_0._canPlaySkill2(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._delayDone, arg_4_0, 20)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, arg_4_0._canPlaySkill2, arg_4_0)

	if FightModel.instance:getVersion() >= 1 then
		if FightHelper.isPlayerCardSkill(arg_4_0.fightStepData) then
			if arg_4_0.fightStepData.cardIndex - 1 > FightPlayCardModel.instance:getCurIndex() then
				FightController.instance:dispatchEvent(FightEvent.InvalidPreUsedCard, arg_4_0.fightStepData.cardIndex)
				TaskDispatcher.runDelay(arg_4_0._delayAfterDissolveCard, arg_4_0, 1 / FightModel.instance:getUISpeed())

				return
			end

			FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, arg_4_0._attacker, arg_4_0._skillId, arg_4_0.fightStepData)
		end

		arg_4_0:_playSkill(arg_4_0._skillId)
	else
		local var_4_0 = not arg_4_0.fightStepData.editorPlaySkill
		local var_4_1 = arg_4_0._attacker:isMySide() and FightCardDataHelper.isActiveSkill(arg_4_0.fightStepData.fromId, arg_4_0._skillId)
		local var_4_2 = FightPlayCardModel.instance:getClientLeftSkillOpList()
		local var_4_3 = var_4_2 and var_4_2[#var_4_2]
		local var_4_4 = var_4_3 and arg_4_0._skillId == var_4_3.skillId

		if var_4_0 and (var_4_1 or var_4_4) then
			local var_4_5 = var_0_3 + var_0_2 - Time.realtimeSinceStartup

			if var_4_5 > 0 then
				TaskDispatcher.runDelay(arg_4_0._toPlaySkill, arg_4_0, var_4_5)
			else
				arg_4_0:_toPlaySkill()
			end
		else
			arg_4_0:_playSkill(arg_4_0._skillId)
		end
	end
end

function var_0_0._delayAfterDissolveCard(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, arg_5_0._attacker, arg_5_0._skillId, arg_5_0.fightStepData)
	arg_5_0:_playSkill(arg_5_0._skillId)
end

function var_0_0._delayPlaySkill(arg_6_0)
	arg_6_0:_playSkill(arg_6_0._skillId)
end

function var_0_0._toPlaySkill(arg_7_0)
	FightController.instance:registerCallback(FightEvent.ToPlaySkill, arg_7_0._playSkill, arg_7_0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, arg_7_0._attacker, arg_7_0._skillId, arg_7_0.fightStepData)
end

function var_0_0._playSkill(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0.fightStepData.actId then
		arg_8_0:onDone(true)

		return
	end

	if arg_8_0.fightStepData.fromId == "0" or arg_8_0._attacker then
		FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, arg_8_0._playSkill, arg_8_0)

		local var_8_0 = arg_8_0._attacker.skill:registPlaySkillWork(arg_8_0._skillId, arg_8_0.fightStepData)

		if var_8_0 then
			var_8_0:registFinishCallback(arg_8_0.onWorkTimelineFinish, arg_8_0)
			TaskDispatcher.cancelTask(arg_8_0._delayDone, arg_8_0)

			if FightScene.ios3GBMemory and (FightDataHelper.fieldMgr.episodeId == SurvivalConst.Shelter_EpisodeId or FightDataHelper.fieldMgr.episodeId == SurvivalConst.Survival_EpisodeId) and (var_8_0.timelineName == "ndk_312002_unique_1" or var_8_0.timelineName == "ndk_312002_unique_1ex") then
				FightHelper.clearNoUseEffect()
			end

			var_8_0:start()
		else
			arg_8_0:onDone(true)
		end
	else
		logError("attacker entity not exist, can't play skill " .. arg_8_0._skillId)
		arg_8_0:onDone(true)
	end
end

function var_0_0.onWorkTimelineFinish(arg_9_0)
	if arg_9_0.status ~= WorkStatus.Done then
		arg_9_0:_removeEvents()

		var_0_3 = Time.realtimeSinceStartup
		var_0_0.needStopSkillEnd = nil

		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillNP)
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillP)

		if var_0_0.needStopSkillEnd then
			TaskDispatcher.cancelTask(arg_9_0._delayDone, arg_9_0)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, arg_9_0._onFightDialogEnd, arg_9_0)
		elseif FightModel.instance:getVersion() >= 1 then
			if FightHelper.isPlayerCardSkill(arg_9_0.fightStepData) then
				TaskDispatcher.runDelay(arg_9_0._delayAfterSkillEnd, arg_9_0, 0.3 / FightModel.instance:getUISpeed())
			else
				arg_9_0:onDone(true)
			end
		else
			arg_9_0:onDone(true)
		end
	end
end

function var_0_0._delayAfterSkillEnd(arg_10_0)
	arg_10_0:onDone(true)
end

function var_0_0._onFightDialogEnd(arg_11_0)
	arg_11_0:onDone(true)
end

function var_0_0._forceEndSkillStep(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0.fightStepData then
		arg_12_0:_removeEvents()
		arg_12_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_13_0)
	logError("skill play timeout, skillId = " .. arg_13_0._skillId)
	arg_13_0:_removeEvents()
	FightController.instance:dispatchEvent(FightEvent.FightWorkStepSkillTimeout, arg_13_0.fightStepData)
end

function var_0_0._removeEvents(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayAfterDissolveCard, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayPlaySkill, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayAfterSkillEnd, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayDone, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._toPlaySkill, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, arg_14_0._playSkill, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, arg_14_0._forceEndSkillStep, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, arg_14_0._canPlaySkill2, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_14_0._onFightDialogEnd, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, arg_14_0._onBeforeDestroyEntity, arg_14_0)
end

function var_0_0._onBeforeDestroyEntity(arg_15_0, arg_15_1)
	if arg_15_0._attacker and arg_15_0._attacker.id == arg_15_1.id then
		arg_15_0:onDone(true)
	end
end

function var_0_0.onStop(arg_16_0)
	var_0_0.super.onStop(arg_16_0)

	if arg_16_0._attacker and arg_16_0._attacker.skill then
		arg_16_0._attacker.skill:stopSkill()
	end
end

function var_0_0.onResume(arg_17_0)
	logError("skill step can't resume")
end

function var_0_0.clearWork(arg_18_0)
	arg_18_0:_removeEvents()
end

return var_0_0
