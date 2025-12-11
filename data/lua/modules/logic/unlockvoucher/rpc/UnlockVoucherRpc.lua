module("modules.logic.unlockvoucher.rpc.UnlockVoucherRpc", package.seeall)

local var_0_0 = class("UnlockVoucherRpc", BaseRpc)

function var_0_0.sendGetUnlockVoucherInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = UnlockVoucherModule_pb.GetUnlockVoucherInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetUnlockVoucherInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.vouchers

	UnlockVoucherController.instance:onGetVoucherInfos(var_2_0)
end

function var_0_0.onReceiveUnlockVoucherInfoUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	local var_3_0 = arg_3_2.vouchers

	UnlockVoucherController.instance:onGetVoucherInfosPush(var_3_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
