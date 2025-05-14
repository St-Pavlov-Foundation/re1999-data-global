module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepCallEvent", package.seeall)

local var_0_0 = class("YaXianStepCallEvent", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = YaXianGameController.instance.state

	if var_1_0 then
		var_1_0:setCurEventByObj(arg_1_0.originData.event)

		arg_1_0._curState = var_1_0:getCurEvent()
	end

	if arg_1_0._curState then
		YaXianGameController.instance:registerCallback(YaXianEvent.OnStateFinish, arg_1_0.onReceiveFinished, arg_1_0)
	else
		arg_1_0:finish()
	end
end

function var_0_0.onReceiveFinished(arg_2_0, arg_2_1)
	if arg_2_0._curState and arg_2_0._curState.stateType == arg_2_1 then
		YaXianGameController.instance:unregisterCallback(YaXianEvent.OnStateFinish, arg_2_0.onReceiveFinished, arg_2_0)
		arg_2_0:finish()
	end
end

function var_0_0.finish(arg_3_0)
	local var_3_0 = YaXianGameController.instance.state

	if var_3_0 then
		var_3_0:disposeEventState()
	end

	var_0_0.super.finish(arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnStateFinish, arg_4_0.onReceiveFinished, arg_4_0)

	local var_4_0 = YaXianGameController.instance.state

	if var_4_0 then
		var_4_0:disposeEventState()
	end
end

return var_0_0
