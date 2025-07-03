module("modules.logic.fight.system.work.FightWorkDamageExtra", package.seeall)

local var_0_0 = class("FightWorkDamageExtra", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0._flow = FlowParallel.New()

	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._resignDone, arg_1_0))
	arg_1_0._flow:addWork(FightWork2Work.New(FightWorkEffectDamage, arg_1_0.fightStepData, arg_1_0.actEffectData))
	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._resignDone, arg_1_0))
	arg_1_0._flow:addWork(FightWork2Work.New(FightBuffTriggerEffect, arg_1_0.fightStepData, arg_1_0.actEffectData))
	arg_1_0._flow:registerDoneListener(arg_1_0._onFlowDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._resignDone(arg_2_0)
	arg_2_0.actEffectData:revertDone()
end

function var_0_0._onFlowDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._flow then
		arg_4_0._flow:unregisterDoneListener(arg_4_0._onFlowDone, arg_4_0)
		arg_4_0._flow:stop()

		arg_4_0._flow = nil
	end
end

return var_0_0
