module("modules.logic.versionactivity2_4.act181.rpc.Activity181Rpc", package.seeall)

slot0 = class("Activity181Rpc", BaseRpc)

function slot0.SendGet181InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity181Module_pb.Get181InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet181InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity181Model.instance:setActInfo(slot2.activityId, slot2)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetInfo)
	end
end

function slot0.SendGet181BonusRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity181Module_pb.Get181BonusRequest()
	slot5.activityId = slot1
	slot5.pos = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveGet181BonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity181Model.instance:setBonusInfo(slot2.activityId, slot2)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetBonus, slot2.activityId, slot2.id, slot2.pos)
	end
end

function slot0.SendGet181SpBonusRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity181Module_pb.Get181SpBonusRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet181SpBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity181Model.instance:setSPBonusInfo(slot2.activityId, slot2)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetSPBonus, slot2.activityId)
	end
end

slot0.instance = slot0.New()

return slot0
