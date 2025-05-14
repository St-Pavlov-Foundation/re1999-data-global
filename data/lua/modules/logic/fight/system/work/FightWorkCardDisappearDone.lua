module("modules.logic.fight.system.work.FightWorkCardDisappearDone", package.seeall)

local var_0_0 = class("FightWorkCardDisappearDone", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10)
	FightController.instance:registerCallback(FightEvent.CardDisappearFinish, arg_2_0._onCardDisappearFinish, arg_2_0)
end

function var_0_0._onCardDisappearFinish(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.CardDisappearFinish, arg_3_0._onCardDisappearFinish, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	logError("卡牌消失超时，isChanging=false")
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.CardDisappearFinish, arg_5_0._onCardDisappearFinish, arg_5_0)
end

return var_0_0
