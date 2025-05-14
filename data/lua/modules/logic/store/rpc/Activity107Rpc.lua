module("modules.logic.store.rpc.Activity107Rpc", package.seeall)

local var_0_0 = class("Activity107Rpc", BaseRpc)

function var_0_0.sendGet107GoodsInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity107Module_pb.Get107GoodsInfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet107GoodsInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ActivityStoreModel.instance:initActivityGoodsInfos(arg_2_2.activityId, arg_2_2.goodsInfos)
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnGet107GoodsInfo, arg_2_2.activityId)
	end
end

function var_0_0.sendBuy107GoodsRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity107Module_pb.Buy107GoodsRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2
	var_3_0.num = arg_3_3

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveBuy107GoodsReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ActivityStoreModel.instance:updateActivityGoodsInfos(arg_4_2.activityId, arg_4_2.goodsInfo)
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnBuy107GoodsSuccess, arg_4_2.activityId, arg_4_2.goodsInfo.id)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
