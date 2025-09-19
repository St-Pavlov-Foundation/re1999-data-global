module("modules.logic.fight.controller.replay.FightReplayWorkPlayCard", package.seeall)

local var_0_0 = class("FightReplayWorkPlayCard", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.cardOp = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_2_0._onCombineCardEnd, arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.SimulatePlayHandCard, arg_2_0.cardOp.param1, arg_2_0.cardOp.toId, arg_2_0.cardOp.param2, arg_2_0.cardOp.param3)
end

function var_0_0._onCombineCardEnd(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_3_0._onCombineCardEnd, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 0.01)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_5_0._onCombineCardEnd, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
end

return var_0_0
