module("modules.logic.fight.system.work.FightWorkWaitDialog", package.seeall)

local var_0_0 = class("FightWorkWaitDialog", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = gohelper.find("UIRoot/HUD/FightView/#go_dialogcontainer")

	if var_1_0 and var_1_0.activeInHierarchy then
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 60)
		FightController.instance:registerCallback(FightEvent.FightDialogShow, arg_1_0._onFightDialogShow, arg_1_0)
		FightController.instance:registerCallback(FightEvent.FightDialogEnd, arg_1_0._onFightDialogEnd, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onFightDialogShow(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 60)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._onFightDialogEnd(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogShow, arg_5_0._onFightDialogShow, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_5_0._onFightDialogEnd, arg_5_0)
end

return var_0_0
