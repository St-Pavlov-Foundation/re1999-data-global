module("modules.logic.fight.controller.replay.FightReplayWorkMoveUniversal", package.seeall)

local var_0_0 = class("FightReplayWorkMoveUniversal", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.cardOp = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightModel.instance:getUISpeed()

	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10 / Mathf.Clamp(var_2_0, 0.01, 100))

	local var_2_1 = 0.1 / Mathf.Clamp(var_2_0, 0.01, 100)

	if arg_2_0.cardOp.param1 == arg_2_0.cardOp.param2 - 1 then
		TaskDispatcher.runDelay(arg_2_0._delaySimulateDragSpecial, arg_2_0, var_2_1)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_2_0._onCombineCardEnd, arg_2_0)
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, arg_2_0.cardOp.param1)
	else
		arg_2_0._index = arg_2_0.cardOp.param1
		arg_2_0._sign = arg_2_0.cardOp.param2 > arg_2_0.cardOp.param1 and 1 or -1
		arg_2_0._endIndex = arg_2_0.cardOp.param2 + arg_2_0._sign

		if arg_2_0.cardOp.param1 < arg_2_0.cardOp.param2 then
			arg_2_0._endIndex = arg_2_0._endIndex - 1
		end

		TaskDispatcher.runRepeat(arg_2_0._delaySimulateDrag, arg_2_0, var_2_1, arg_2_0.cardOp.param2 - arg_2_0.cardOp.param1 + 1)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_2_0._onCombineCardEnd, arg_2_0)
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardBegin, arg_2_0.cardOp.param1)
	end
end

function var_0_0._delaySimulateDragSpecial(arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, arg_3_0.cardOp.param1, arg_3_0.cardOp.param1)

	local var_3_0 = FightModel.instance:getUISpeed()
	local var_3_1 = 0.2 / Mathf.Clamp(var_3_0, 0.01, 100)

	TaskDispatcher.runDelay(arg_3_0._delaySimulateDragEnd, arg_3_0, var_3_1)
end

function var_0_0._delaySimulateDrag(arg_4_0)
	arg_4_0._index = arg_4_0._index + arg_4_0._sign

	if arg_4_0._index ~= arg_4_0._endIndex then
		FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCard, arg_4_0.cardOp.param1, arg_4_0._index)
	else
		TaskDispatcher.cancelTask(arg_4_0._delaySimulateDrag, arg_4_0)
		TaskDispatcher.runDelay(arg_4_0._delaySimulateDragEnd, arg_4_0, 0.2)
	end
end

function var_0_0._delaySimulateDragEnd(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, arg_5_0.cardOp.param1, arg_5_0.cardOp.param2)
end

function var_0_0._onCombineCardEnd(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._delayDone, arg_6_0, 0.01)
end

function var_0_0._delayDone(arg_7_0)
	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_8_0._onCombineCardEnd, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delaySimulateDragSpecial, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delaySimulateDrag, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delaySimulateDragEnd, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayDone, arg_8_0)
end

return var_0_0
