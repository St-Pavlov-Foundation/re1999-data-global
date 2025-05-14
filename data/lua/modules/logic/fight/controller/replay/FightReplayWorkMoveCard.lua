module("modules.logic.fight.controller.replay.FightReplayWorkMoveCard", package.seeall)

local var_0_0 = class("FightReplayWorkMoveCard", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.cardOp = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._index = arg_2_0.cardOp.param1
	arg_2_0._sign = arg_2_0.cardOp.param2 > arg_2_0.cardOp.param1 and 1 or -1
	arg_2_0._endIndex = arg_2_0.cardOp.param2 + arg_2_0._sign

	local var_2_0 = FightModel.instance:getUISpeed()
	local var_2_1 = 0.1 / Mathf.Clamp(var_2_0, 0.01, 100)

	TaskDispatcher.runRepeat(arg_2_0._delaySimulateDrag, arg_2_0, var_2_1, arg_2_0.cardOp.param2 - arg_2_0.cardOp.param1 + 1)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_2_0._onCombineCardEnd, arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, arg_2_0.cardOp.param1)
end

function var_0_0._delaySimulateDrag(arg_3_0)
	arg_3_0._index = arg_3_0._index + arg_3_0._sign

	if arg_3_0._index ~= arg_3_0._endIndex then
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, arg_3_0.cardOp.param1, arg_3_0._index)
	else
		TaskDispatcher.cancelTask(arg_3_0._delaySimulateDrag, arg_3_0)

		local var_3_0 = FightModel.instance:getUISpeed()
		local var_3_1 = 0.2 / Mathf.Clamp(var_3_0, 0.01, 100)

		TaskDispatcher.runDelay(arg_3_0._delaySimulateDragEnd, arg_3_0, var_3_1)
	end
end

function var_0_0._delaySimulateDragEnd(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, arg_4_0.cardOp.param1, arg_4_0.cardOp.param2)
end

function var_0_0._onCombineCardEnd(arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayDone, arg_5_0, 0.01)
end

function var_0_0._delayDone(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_7_0._onCombineCardEnd, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delaySimulateDrag, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delaySimulateDragEnd, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delayDone, arg_7_0)
end

return var_0_0
