module("modules.logic.versionactivity3_1.nationalgift.rpc.Activity212Rpc", package.seeall)

local var_0_0 = class("Activity212Rpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGetAct212InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity212Module_pb.GetAct212InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct212InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	NationalGiftModel.instance:setActInfo(arg_2_2.act212Info)
	NationalGiftController.instance:dispatchEvent(NationalGiftEvent.onAct212InfoGet)
end

function var_0_0.sendAct212ReceiveBonusRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity212Module_pb.Act212ReceiveBonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct212ReceiveBonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	NationalGiftModel.instance:updateBonusStatus(arg_4_2.id, arg_4_2.status, arg_4_2.activityId)
	NationalGiftController.instance:dispatchEvent(NationalGiftEvent.onAct212InfoUpdate)
end

function var_0_0.onReceiveAct212BonusPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	NationalGiftModel.instance:setActInfo(arg_5_2.act212Info)
	NationalGiftController.instance:dispatchEvent(NationalGiftEvent.OnAct212BonusUpdate)
end

return var_0_0
