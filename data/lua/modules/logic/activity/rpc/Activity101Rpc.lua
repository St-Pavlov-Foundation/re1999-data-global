module("modules.logic.activity.rpc.Activity101Rpc", package.seeall)

slot0 = class("Activity101Rpc", BaseRpc)

function slot0.sendGet101InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity101Module_pb.Get101InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet101InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityType101Model.instance:setType101Info(slot2)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function slot0.sendGet101BonusRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity101Module_pb.Get101BonusRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveGet101BonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityType101Model.instance:setBonusGet(slot2)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function slot0.sendGet101SpBonusRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity101Module_pb.Get101SpBonusRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveGet101SpBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ActivityType101Model.instance:setSpBonusGet(slot2)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

slot0.instance = slot0.New()

return slot0
