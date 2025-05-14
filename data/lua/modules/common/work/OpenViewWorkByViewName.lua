module("modules.common.work.OpenViewWorkByViewName", package.seeall)

local var_0_0 = class("OpenViewWorkByViewName", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.viewName = arg_1_1
	arg_1_0.viewParam = arg_1_2
	arg_1_0.eventName = arg_1_3 or ViewEvent.OnOpenView
end

function var_0_0.onStart(arg_2_0)
	ViewMgr.instance:registerCallback(arg_2_0.eventName, arg_2_0.onEventFinish, arg_2_0)
	ViewMgr.instance:openView(arg_2_0.viewName, arg_2_0.viewParam)
end

function var_0_0.onEventFinish(arg_3_0)
	ViewMgr.instance:unregisterCallback(arg_3_0.eventName, arg_3_0.onEventFinish, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(arg_4_0.eventName, arg_4_0.onEventFinish, arg_4_0)
end

return var_0_0
