module("modules.logic.dispatch.controller.DispatchController", package.seeall)

local var_0_0 = class("DispatchController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openDispatchView(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0

	if arg_5_1 then
		var_5_0 = DispatchEnum.ActId2View[arg_5_1]
	end

	if not var_5_0 then
		logError(string.format("DispatchController:openDispatchView error,DispatchEnum.ActId2View not have view, actId:%s", arg_5_1))

		return
	end

	if DispatchModel.instance:getDispatchStatus(arg_5_2, arg_5_3) == DispatchEnum.DispatchStatus.Finished then
		return
	end

	DispatchModel.instance:checkDispatchFinish()
	ViewMgr.instance:openView(var_5_0, {
		elementId = arg_5_2,
		dispatchId = arg_5_3
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
