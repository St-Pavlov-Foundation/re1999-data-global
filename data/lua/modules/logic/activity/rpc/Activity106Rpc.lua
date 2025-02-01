module("modules.logic.activity.rpc.Activity106Rpc", package.seeall)

slot0 = class("Activity106Rpc", BaseRpc)

function slot0.sendGet106InfosRequest(slot0, slot1)
	slot2 = Activity106Module_pb.Get106InfosRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGet106InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityWarmUpController.instance:onReceiveInfos(slot2.activityId, slot2.orderInfos)
	end
end

function slot0.sendGet106OrderBonusRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity106Module_pb.Get106OrderBonusRequest()
	slot6.activityId = slot1
	slot6.orderId = slot2
	slot6.useSecond = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveGet106OrderBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityWarmUpController.instance:onUpdateSingleOrder(slot2.activityId, slot2.orderInfo)
	end
end

function slot0.onReceiveUpdate106OrderPush(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityWarmUpController.instance:onOrderPush(slot2.activityId, slot2.orderInfo)
	end
end

slot0.instance = slot0.New()

return slot0
