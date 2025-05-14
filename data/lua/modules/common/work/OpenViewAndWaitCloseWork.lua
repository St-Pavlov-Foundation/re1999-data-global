module("modules.common.work.OpenViewAndWaitCloseWork", package.seeall)

local var_0_0 = class("OpenViewAndWaitCloseWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.viewName = arg_1_1
	arg_1_0.viewParam = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	ViewMgr.instance:openView(arg_2_0.viewName, arg_2_0.viewParam)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_0.viewName == arg_3_1 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
end

return var_0_0
