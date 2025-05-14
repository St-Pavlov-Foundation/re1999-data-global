module("modules.logic.rouge.map.view.finish.RougeFinishViewContainer", package.seeall)

local var_0_0 = class("RougeFinishViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeFinishView.New())

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.onCloseAnimDone, arg_2_0, 0.5)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
end

function var_0_0.onCloseAnimDone(arg_3_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onFinishViewDone)
end

function var_0_0.onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.RougeResultView then
		arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0.onOpenView, arg_4_0)
		arg_4_0:onPlayCloseTransitionFinish()
	end
end

return var_0_0
