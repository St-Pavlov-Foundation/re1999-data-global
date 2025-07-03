module("modules.logic.fight.view.preview.FightSkillEditorFlow", package.seeall)

local var_0_0 = class("FightSkillEditorFlow", BaseFlow)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._skillReleaseFlow = FlowParallel.New()

	arg_1_0._skillReleaseFlow:addWork(FunctionWork.New(arg_1_0._playSkill, arg_1_0))

	local var_1_0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.actEffect) do
		if (iter_1_1.effectType == FightEnum.EffectType.HEAL or iter_1_1.effectType == FightEnum.EffectType.HEALCRIT) and iter_1_1.effectNum > 0 then
			if not var_1_0 then
				var_1_0 = FightWorkSkillFinallyHeal.New(arg_1_1)

				arg_1_0._skillReleaseFlow:addWork(var_1_0)
			end

			var_1_0:addActEffectData(iter_1_1)
		end
	end
end

function var_0_0._playSkill(arg_2_0)
	arg_2_0._attacker = FightHelper.getEntity(arg_2_0.fightStepData.fromId)
	arg_2_0._skillId = arg_2_0.fightStepData.actId

	local var_2_0 = arg_2_0._attacker:getMO()
	local var_2_1 = var_2_0 and var_2_0.skin
	local var_2_2 = FightConfig.instance:getSkinSkillTimeline(var_2_1, arg_2_0._skillId)

	if string.nilorempty(var_2_2) then
		arg_2_0:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillEnd, arg_2_0)

	if FightSkillMgr.instance:isEntityPlayingTimeline(arg_2_0._attacker.id) then
		TaskDispatcher.runRepeat(arg_2_0._checkNoSkillPlaying, arg_2_0, 0.01)
	else
		arg_2_0._attacker.skill:playSkill(arg_2_0._skillId, arg_2_0.fightStepData)
	end
end

function var_0_0._checkNoSkillPlaying(arg_3_0)
	if not FightSkillMgr.instance:isEntityPlayingTimeline(arg_3_0._attacker.id) then
		TaskDispatcher.cancelTask(arg_3_0._checkNoSkillPlaying, arg_3_0)
		arg_3_0._attacker.skill:playSkill(arg_3_0._skillId, arg_3_0.fightStepData)
	end
end

function var_0_0._onSkillEnd(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillEnd, arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0._skillReleaseFlow:start()
end

function var_0_0.clearWork(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	if arg_7_0._skillReleaseFlow then
		arg_7_0._skillReleaseFlow:stop()

		arg_7_0._skillReleaseFlow = nil
	end

	var_0_0.super.onDestroy(arg_7_0)
end

function var_0_0.stopSkillFlow(arg_8_0)
	if arg_8_0._skillReleaseFlow and arg_8_0._skillReleaseFlow.status == WorkStatus.Running then
		local var_8_0 = arg_8_0._skillReleaseFlow:getWorkList()

		for iter_8_0 = arg_8_0._skillReleaseFlow._curIndex, #var_8_0 do
			var_8_0[iter_8_0]:onDone(true)
		end

		arg_8_0._skillReleaseFlow:stop()

		arg_8_0._skillReleaseFlow = nil
	end
end

return var_0_0
