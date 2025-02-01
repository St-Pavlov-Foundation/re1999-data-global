module("modules.logic.store.rpc.StoreRpc", package.seeall)

slot0 = class("StoreRpc", BaseRpc)

function slot0.sendGetStoreInfosRequest(slot0, slot1, slot2, slot3)
	slot4 = StoreModule_pb.GetStoreInfosRequest()

	if not slot1 or #slot1 <= 0 then
		slot1 = StoreConfig.instance:getAllStoreIds()
	end

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.storeIds, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetStoreInfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		StoreModel.instance:getStoreInfosReply(slot2)
		StoreController.instance:dispatchEvent(StoreEvent.StoreInfoChanged)
	end
end

function slot0.sendBuyGoodsRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = StoreModule_pb.BuyGoodsRequest()
	slot7.storeId = slot1
	slot7.goodsId = slot2
	slot7.num = slot3
	slot7.selectCost = slot6 or 1

	return slot0:sendMsg(slot7, slot4, slot5)
end

function slot0.onReceiveBuyGoodsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		StoreModel.instance:buyGoodsReply(slot2)
		table.insert({}, slot2.storeId)

		if slot2.storeId ~= StoreEnum.SubRoomNew and slot2.storeId ~= StoreEnum.SubRoomOld then
			uv0.instance:sendGetStoreInfosRequest(slot3)
		end

		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged, slot2.goodsId)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end
end

function slot0.sendReadStoreNewRequest(slot0, slot1)
	slot2 = StoreModule_pb.ReadStoreNewRequest()

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2.goodsIds, slot7)
	end

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveReadStoreNewReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

slot0.instance = slot0.New()

return slot0
