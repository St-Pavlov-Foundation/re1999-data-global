module("modules.logic.activity.controller.chessmap.step.ActivityChessStepCallEvent", package.seeall)

local var_0_0 = class("ActivityChessStepCallEvent", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.event
	local var_1_1 = ActivityChessGameController.instance.event

	if var_1_1 then
		var_1_1:setCurEventByObj(var_1_0)

		arg_1_0._curEvent = var_1_1:getCurEvent()
	end

	if arg_1_0._curEvent then
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.EventFinishPlay, arg_1_0.onReceiveFinished, arg_1_0)
	else
		arg_1_0:finish()
	end
end

function var_0_0.onReceiveFinished(arg_2_0, arg_2_1)
	if arg_2_0._curEvent == arg_2_1 then
		ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.EventFinishPlay, arg_2_0.onReceiveFinished, arg_2_0)
		arg_2_0:finish()
	end
end

function var_0_0.finish(arg_3_0)
	local var_3_0 = ActivityChessGameController.instance.event

	if var_3_0 then
		var_3_0:setLockEvent()
	end

	var_0_0.super.finish(arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.EventFinishPlay, arg_4_0.onReceiveFinished, arg_4_0)

	arg_4_0._curEvent = nil

	var_0_0.super.dispose(arg_4_0)
end

return var_0_0
