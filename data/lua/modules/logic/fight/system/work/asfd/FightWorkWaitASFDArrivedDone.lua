module("modules.logic.fight.system.work.asfd.FightWorkWaitASFDArrivedDone", package.seeall)

local var_0_0 = class("FightWorkWaitASFDArrivedDone", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 5)
	FightController.instance:registerCallback(FightEvent.ASFD_OnASFDArrivedDone, arg_2_0.onASFDArrivedDone, arg_2_0)
end

function var_0_0.onASFDArrivedDone(arg_3_0, arg_3_1)
	if arg_3_1 ~= arg_3_0.fightStepData then
		return
	end

	return arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_OnASFDArrivedDone, arg_4_0.onASFDArrivedDone, arg_4_0)
end

function var_0_0._delayDone(arg_5_0)
	logError("奥术飞弹 wait arrived 超时了")

	return arg_5_0:onDone(true)
end

return var_0_0
