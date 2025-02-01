module("modules.logic.store.rpc.Activity107Rpc", package.seeall)

slot0 = class("Activity107Rpc", BaseRpc)

function slot0.sendGet107GoodsInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity107Module_pb.Get107GoodsInfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet107GoodsInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityStoreModel.instance:initActivityGoodsInfos(slot2.activityId, slot2.goodsInfos)
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnGet107GoodsInfo, slot2.activityId)
	end
end

function slot0.sendBuy107GoodsRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity107Module_pb.Buy107GoodsRequest()
	slot4.activityId = slot1
	slot4.id = slot2
	slot4.num = slot3

	return slot0:sendMsg(slot4)
end

function slot0.onReceiveBuy107GoodsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityStoreModel.instance:updateActivityGoodsInfos(slot2.activityId, slot2.goodsInfo)
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnBuy107GoodsSuccess, slot2.activityId, slot2.goodsInfo.id)
	end
end

slot0.instance = slot0.New()

return slot0
