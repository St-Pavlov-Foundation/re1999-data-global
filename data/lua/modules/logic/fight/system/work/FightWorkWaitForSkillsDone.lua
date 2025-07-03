module("modules.logic.fight.system.work.FightWorkWaitForSkillsDone", package.seeall)

local var_0_0 = class("FightWorkWaitForSkillsDone", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._skillFlowList = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0:_checkDone() then
		arg_2_0:onDone(true)
	else
		local var_2_0 = FightModel.instance:getSpeed()
		local var_2_1 = FightModel.instance:getUISpeed()
		local var_2_2 = math.min(var_2_0, var_2_1)
		local var_2_3 = 5 / Mathf.Clamp(var_2_2, 0.01, 1)

		TaskDispatcher.runRepeat(arg_2_0._onTick, arg_2_0, 0.1)
		TaskDispatcher.runDelay(arg_2_0._timeOut, arg_2_0, var_2_3)
	end
end

function var_0_0._onTick(arg_3_0)
	if arg_3_0:_checkDone() then
		arg_3_0:onDone(true)
	end
end

function var_0_0._timeOut(arg_4_0)
	if arg_4_0._skillFlowList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._skillFlowList) do
			if not iter_4_1:hasDone() then
				logError("检测回合技能完成超时，技能id = " .. iter_4_1.fightStepData.actId)
			end
		end
	end

	arg_4_0:onDone(true)
end

function var_0_0._checkDone(arg_5_0)
	if arg_5_0._skillFlowList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._skillFlowList) do
			if not iter_5_1:hasDone() then
				return false
			end
		end
	end

	return true
end

function var_0_0.clearWork(arg_6_0)
	arg_6_0._skillFlowList = nil

	TaskDispatcher.cancelTask(arg_6_0._onTick, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._timeOut, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_6_0._onCombineDone, arg_6_0)
end

return var_0_0
