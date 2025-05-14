module("modules.logic.battlepass.flow.BpCloseViewWork", package.seeall)

local var_0_0 = class("BpCloseViewWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._viewName = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0._viewName)
	arg_2_0:onDone(true)
end

return var_0_0
