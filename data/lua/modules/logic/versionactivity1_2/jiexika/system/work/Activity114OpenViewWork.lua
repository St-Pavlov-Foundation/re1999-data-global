module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenViewWork", package.seeall)

local var_0_0 = class("Activity114OpenViewWork", Activity114BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._viewName = arg_1_1

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
	ViewMgr.instance:openView(arg_2_0._viewName, arg_2_1)
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0._viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_4_0._onCloseViewFinish, arg_4_0)
	var_0_0.super.clearWork(arg_4_0)
end

return var_0_0
