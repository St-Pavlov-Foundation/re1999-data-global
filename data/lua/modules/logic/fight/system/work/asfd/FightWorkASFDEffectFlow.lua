module("modules.logic.fight.system.work.asfd.FightWorkASFDEffectFlow", package.seeall)

local var_0_0 = class("FightWorkASFDEffectFlow", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightStepBuilder._buildEffectWorks(arg_2_0.fightStepData)

	arg_2_0.stepWork = var_2_0 and var_2_0[1]

	if not arg_2_0.stepWork then
		return arg_2_0:onDone(true)
	end

	arg_2_0.stepWork:registerDoneListener(arg_2_0.onEffectWorkDone, arg_2_0)
	arg_2_0.stepWork:onStartInternal()
end

function var_0_0.onEffectWorkDone(arg_3_0)
	return arg_3_0:onDone(true)
end

return var_0_0
