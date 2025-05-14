module("modules.logic.patface.controller.PatFaceFlowSequence", package.seeall)

local var_0_0 = class("PatFaceFlowSequence", FlowSequence)
local var_0_1 = "PatFaceUIBlock"

function var_0_0.isContinuePopView(arg_1_0)
	return arg_1_0._curIndex < #arg_1_0._workList
end

function var_0_0._runNext(arg_2_0)
	local var_2_0 = arg_2_0._curIndex + 1

	if var_2_0 > #arg_2_0._workList then
		arg_2_0._curIndex = var_2_0

		arg_2_0:onDone(true)

		return
	end

	UIBlockMgr.instance:startBlock(var_0_1)
	arg_2_0:_waitInMainView()
end

function var_0_0._waitInMainView(arg_3_0)
	UIBlockMgr.instance:endBlock(var_0_1)

	if MainController.instance:isInMainView() then
		var_0_0.super._runNext(arg_3_0)
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._viewChangeCheckIsInMainView, arg_3_0)
	end
end

function var_0_0._removeViewChangeEvent(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._viewChangeCheckIsInMainView, arg_4_0)
end

function var_0_0._onOpenViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 ~= ViewName.MainView then
		return
	end

	arg_5_0:_viewChangeCheckIsInMainView()
end

function var_0_0._viewChangeCheckIsInMainView(arg_6_0)
	if not MainController.instance:isInMainView() then
		return
	end

	arg_6_0:_removeViewChangeEvent()
	arg_6_0:_runNext()
end

function var_0_0.clearWork(arg_7_0)
	arg_7_0:_removeViewChangeEvent()
	UIBlockMgr.instance:endBlock(var_0_1)
end

return var_0_0
