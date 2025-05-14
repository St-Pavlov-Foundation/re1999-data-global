module("modules.logic.popup.model.PopupCacheModel", package.seeall)

local var_0_0 = class("PopupCacheModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.recordCachePopupParam(arg_3_0, arg_3_1)
	arg_3_0:addAtLast(arg_3_1)
end

function var_0_0.popNextPopupParam(arg_4_0)
	return (arg_4_0:removeFirst())
end

var_0_0.instance = var_0_0.New()

return var_0_0
