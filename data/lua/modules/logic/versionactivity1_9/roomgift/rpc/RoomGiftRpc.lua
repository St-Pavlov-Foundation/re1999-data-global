module("modules.logic.versionactivity1_9.roomgift.rpc.RoomGiftRpc", package.seeall)

slot0 = class("RoomGiftRpc", BaseRpc)

function slot0.sendGet159InfosRequest(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = Activity159Module_pb.Get159InfosRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGet159InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomGiftModel.instance:setActivityInfo(slot2)
	RoomGiftController.instance:dispatchEvent(RoomGiftEvent.UpdateActInfo)
end

function slot0.sendGet159BonusRequest(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = Activity159Module_pb.Get159BonusRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGet159BonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RoomGiftModel.instance:setHasGotBonus(true)
	RoomGiftController.instance:dispatchEvent(RoomGiftEvent.GetBonus)
end

slot0.instance = slot0.New()

return slot0
