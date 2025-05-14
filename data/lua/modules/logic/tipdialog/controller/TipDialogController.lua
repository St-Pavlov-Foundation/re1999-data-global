module("modules.logic.tipdialog.controller.TipDialogController", package.seeall)

local var_0_0 = class("TipDialogController", BaseController)

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

function var_0_0.openTipDialogView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0 = {
		dialogId = arg_5_1,
		callback = arg_5_2,
		callbackTarget = arg_5_3,
		auto = arg_5_4,
		autoplayTime = arg_5_5,
		widthPercentage = arg_5_6
	}

	ViewMgr.instance:openView(ViewName.TipDialogView, var_5_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
