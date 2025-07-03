module("modules.logic.fight.system.work.asfd.FightWorkASFDContinueDone", package.seeall)

local var_0_0 = class("FightWorkASFDContinueDone", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 3)

	local var_2_0 = FightHelper.getASFDMgr()

	if var_2_0 then
		var_2_0:onContinueASFDFlowDone(arg_2_0.fightStepData)
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnDone, arg_2_0.fightStepData and arg_2_0.fightStepData.cardIndex)

	return arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	logError("奥术飞弹 Continue Done 超时了")

	return arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
