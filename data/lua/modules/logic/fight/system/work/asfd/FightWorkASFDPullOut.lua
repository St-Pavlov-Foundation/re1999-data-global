module("modules.logic.fight.system.work.asfd.FightWorkASFDPullOut", package.seeall)

local var_0_0 = class("FightWorkASFDPullOut", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_PullOut, arg_2_0.fightStepData)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.3)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

function var_0_0._delayDone(arg_4_0)
	return arg_4_0:onDone(true)
end

return var_0_0
