module("modules.logic.fight.system.work.FightStepEffectWork", package.seeall)

local var_0_0 = class("FightStepEffectWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._workFlow = nil
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0._workFlow then
		return arg_2_0._workFlow:start()
	end
end

function var_0_0.setFlow(arg_3_0, arg_3_1)
	arg_3_0._workFlow = arg_3_1

	arg_3_1:registFinishCallback(arg_3_0._onFlowDone, arg_3_0)
end

function var_0_0._onFlowDone(arg_4_0)
	return arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._workFlow then
		arg_5_0._workFlow:disposeSelf()

		arg_5_0._workFlow = nil
	end
end

return var_0_0
