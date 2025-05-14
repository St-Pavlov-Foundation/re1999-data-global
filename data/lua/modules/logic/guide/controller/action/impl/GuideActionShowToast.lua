module("modules.logic.guide.controller.action.impl.GuideActionShowToast", package.seeall)

local var_0_0 = class("GuideActionShowToast", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._toastId = tonumber(arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	if arg_2_0._toastId then
		GameFacade.showToast(arg_2_0._toastId)
	else
		logError("指引飘字失败，没配飘字id")
	end

	arg_2_0:onDone(true)
end

return var_0_0
