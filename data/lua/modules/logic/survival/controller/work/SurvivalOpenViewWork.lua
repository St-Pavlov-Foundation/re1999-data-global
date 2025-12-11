module("modules.logic.survival.controller.work.SurvivalOpenViewWork", package.seeall)

local var_0_0 = class("SurvivalOpenViewWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewName = arg_1_1.viewName
	arg_1_0.viewParam = arg_1_1.viewParam
	arg_1_0.isImmediate = arg_1_1.isImmediate
end

function var_0_0.onStart(arg_2_0)
	local var_2_0, var_2_1 = pcall(arg_2_0.open, arg_2_0)

	if not var_2_0 then
		__G__TRACKBACK__(var_2_1)
		arg_2_0:onDone(false)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
end

function var_0_0.open(arg_3_0)
	ViewMgr.instance:openView(arg_3_0.viewName, arg_3_0.viewParam, arg_3_0.isImmediate)
end

function var_0_0.onOpenView(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_5_0.onOpenView, arg_5_0)
end

function var_0_0.onDestroy(arg_6_0)
	return
end

return var_0_0
