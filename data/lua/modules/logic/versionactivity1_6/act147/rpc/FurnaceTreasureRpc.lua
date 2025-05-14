module("modules.logic.versionactivity1_6.act147.rpc.FurnaceTreasureRpc", package.seeall)

local var_0_0 = class("FurnaceTreasureRpc", BaseRpc)

function var_0_0.sendGetAct147InfosRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity147Module_pb.GetAct147InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetAct147InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		FurnaceTreasureModel.instance:setServerData(arg_2_2, true)
	end
end

function var_0_0.sendBuyAct147GoodsRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	local var_3_0 = Activity147Module_pb.BuyAct147GoodsRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.goodsId = arg_3_3
	var_3_0.buyCount = arg_3_4
	var_3_0.storeId = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_5, arg_3_6)
end

function var_0_0.onReceiveBuyAct147GoodsReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		FurnaceTreasureModel.instance:updateGoodsData(arg_4_2)
		FurnaceTreasureModel.instance:decreaseTotalRemainCount(arg_4_2.activityId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
