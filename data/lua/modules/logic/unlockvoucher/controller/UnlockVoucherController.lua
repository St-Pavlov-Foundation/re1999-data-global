module("modules.logic.unlockvoucher.controller.UnlockVoucherController", package.seeall)

local var_0_0 = class("UnlockVoucherController", BaseController)

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

function var_0_0.onGetVoucherInfos(arg_5_0, arg_5_1)
	UnlockVoucherModel.instance:setVoucherInfos(arg_5_1)
	arg_5_0:dispatchEvent(UnlockVoucherEvent.OnUpdateUnlockVoucherInfo)
end

function var_0_0.onGetVoucherInfosPush(arg_6_0, arg_6_1)
	UnlockVoucherModel.instance:updateVoucherInfos(arg_6_1)
	arg_6_0:dispatchEvent(UnlockVoucherEvent.OnUpdateUnlockVoucherInfo)
end

var_0_0.instance = var_0_0.New()

return var_0_0
