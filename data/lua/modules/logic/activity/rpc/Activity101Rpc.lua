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

function slot0.sendGetAct186SpBonusInfoRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity101Module_pb.GetAct186SpBonusInfoRequest()
	slot5.activityId = slot1
	slot5.act186ActivityId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveGetAct186SpBonusInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity186Model.instance:onGetAct186SpBonusInfo(slot2)
		Activity186Controller.instance:dispatchEvent(Activity186Event.SpBonusStageChange)
	end
end

function slot0.sendAcceptAct186SpBonusRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity101Module_pb.AcceptAct186SpBonusRequest()
	slot5.activityId = slot1
	slot5.act186ActivityId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAcceptAct186SpBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity186Model.instance:onAcceptAct186SpBonus(slot2)
		Activity186Controller.instance:dispatchEvent(Activity186Event.SpBonusStageChange)
		Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
	end
end

slot0.instance = slot0.New()

return slot0
