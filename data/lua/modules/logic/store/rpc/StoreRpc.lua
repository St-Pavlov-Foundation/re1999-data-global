module("modules.logic.store.rpc.StoreRpc", package.seeall)

local var_0_0 = class("StoreRpc", BaseRpc)

function var_0_0.sendGetStoreInfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = StoreModule_pb.GetStoreInfosRequest()

	if not arg_1_1 or #arg_1_1 <= 0 then
		arg_1_1 = StoreConfig.instance:getAllStoreIds()
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		table.insert(var_1_0.storeIds, iter_1_1)
	end

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetStoreInfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		StoreModel.instance:getStoreInfosReply(arg_2_2)
		StoreController.instance:dispatchEvent(StoreEvent.StoreInfoChanged)
	end
end

function var_0_0.sendBuyGoodsRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	local var_3_0 = StoreModule_pb.BuyGoodsRequest()

	var_3_0.storeId = arg_3_1
	var_3_0.goodsId = arg_3_2
	var_3_0.num = arg_3_3
	var_3_0.selectCost = arg_3_6 or 1

	return arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveBuyGoodsReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		StoreModel.instance:buyGoodsReply(arg_4_2)

		local var_4_0 = {}

		table.insert(var_4_0, arg_4_2.storeId)

		if arg_4_2.storeId ~= StoreEnum.StoreId.NewRoomStore and arg_4_2.storeId ~= StoreEnum.StoreId.OldRoomStore then
			var_0_0.instance:sendGetStoreInfosRequest(var_4_0)
		end

		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged, arg_4_2.goodsId)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end

	ChargePushStatController.instance:statBuyFinished(arg_4_1, arg_4_2)
end

function var_0_0.sendReadStoreNewRequest(arg_5_0, arg_5_1)
	local var_5_0 = StoreModule_pb.ReadStoreNewRequest()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(var_5_0.goodsIds, iter_5_1)
	end

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveReadStoreNewReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		-- block empty
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
