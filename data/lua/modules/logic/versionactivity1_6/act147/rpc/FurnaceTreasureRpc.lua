module("modules.logic.versionactivity1_6.act147.rpc.FurnaceTreasureRpc", package.seeall)

slot0 = class("FurnaceTreasureRpc", BaseRpc)

function slot0.sendGetAct147InfosRequest(slot0, slot1)
	slot2 = Activity147Module_pb.GetAct147InfosRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct147InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FurnaceTreasureModel.instance:setServerData(slot2, true)
	end
end

function slot0.sendBuyAct147GoodsRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = Activity147Module_pb.BuyAct147GoodsRequest()
	slot7.activityId = slot1
	slot7.goodsId = slot3
	slot7.buyCount = slot4
	slot7.storeId = slot2

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveBuyAct147GoodsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FurnaceTreasureModel.instance:updateGoodsData(slot2)
		FurnaceTreasureModel.instance:decreaseTotalRemainCount(slot2.activityId)
	end
end

slot0.instance = slot0.New()

return slot0
