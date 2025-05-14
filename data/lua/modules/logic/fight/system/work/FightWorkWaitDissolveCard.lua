module("modules.logic.fight.system.work.FightWorkWaitDissolveCard", package.seeall)

local var_0_0 = class("FightWorkWaitDissolveCard", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._fightStepMO = arg_1_1
	arg_1_0._fightActEffectMO = arg_1_2
	arg_1_0._isDeadInSkill = arg_1_3
end

function var_0_0.onStart(arg_2_0)
	if FightModel.instance:getVersion() >= 1 then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightDataHelper.entityMgr:getById(arg_2_0._fightActEffectMO.targetId)

	if not var_2_0 or var_2_0.side ~= FightEnum.EntitySide.MySide then
		arg_2_0:onDone(true)

		return
	end

	if arg_2_0._isDeadInSkill then
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	else
		local var_2_1 = FightModel.instance:getUISpeed()
		local var_2_2 = 0.5 / Mathf.Clamp(var_2_1, 0.01, 100)

		TaskDispatcher.runDelay(arg_2_0._waitForCardDissolveStart, arg_2_0, var_2_2)
	end
end

function var_0_0._onSkillPlayFinish(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_3 == arg_3_0._fightStepMO then
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)

		local var_3_0 = FightModel.instance:getUISpeed()
		local var_3_1 = 0.5 / Mathf.Clamp(var_3_0, 0.01, 100)

		TaskDispatcher.runDelay(arg_3_0._waitForCardDissolveStart, arg_3_0, var_3_1)
	end
end

function var_0_0._waitForCardDissolveStart(arg_4_0)
	if FightCardModel.instance:isDissolving() then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_4_0._onCombineCardEnd, arg_4_0)

		local var_4_0 = FightModel.instance:getUISpeed()
		local var_4_1 = 10 / Mathf.Clamp(var_4_0, 0.01, 100)

		TaskDispatcher.runDelay(arg_4_0._timeOut, arg_4_0, var_4_1)
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0._onCombineCardEnd(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_5_0._onCombineCardEnd, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayDone, arg_5_0, 0.1 / FightModel.instance:getUISpeed())
end

function var_0_0._timeOut(arg_6_0)
	logNormal("FightWorkWaitDissolveCard 奇怪，超时结束 done")
	arg_6_0:onDone(true)
end

function var_0_0._delayDone(arg_7_0)
	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_8_0._onSkillPlayFinish, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_8_0._onCombineCardEnd, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._waitForCardDissolveStart, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._timeOut, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayDone, arg_8_0)
end

return var_0_0
