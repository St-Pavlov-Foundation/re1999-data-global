module("modules.logic.rouge.map.work.WaitRougeActorMoveToEndDoneWork", package.seeall)

local var_0_0 = class("WaitRougeActorMoveToEndDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if not RougeMapModel.instance:needPlayMoveToEndAnim() then
		return arg_2_0:onDone(true)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
	RougeMapController.instance:registerCallback(RougeMapEvent.onEndActorMoveToEnd, arg_2_0.onEndActorMoveToEnd, arg_2_0)
end

function var_0_0.onEndActorMoveToEnd(arg_3_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onEndActorMoveToEnd, arg_3_0.onEndActorMoveToEnd, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onEndActorMoveToEnd, arg_4_0.onEndActorMoveToEnd, arg_4_0)
end

return var_0_0
