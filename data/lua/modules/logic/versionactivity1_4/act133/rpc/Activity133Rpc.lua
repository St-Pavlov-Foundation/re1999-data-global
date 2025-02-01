module("modules.logic.versionactivity1_4.act133.rpc.Activity133Rpc", package.seeall)

slot0 = class("Activity133Rpc", BaseRpc)

function slot0.sendGet133InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity133Module_pb.Get133InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet133InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity133Model.instance:setActivityInfo(slot2)
	Activity133Controller.instance:dispatchEvent(Activity133Event.OnUpdateInfo)
end

function slot0.sendAct133BonusRequest(slot0, slot1, slot2)
	slot3 = Activity133Module_pb.Act133BonusRequest()
	slot3.activityId = slot1
	slot3.id = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct133BonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot0:sendGet133InfosRequest(VersionActivity1_4Enum.ActivityId.ShipRepair, function ()
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnGetBonus, uv0)
	end, slot0)
end

slot0.instance = slot0.New()

return slot0
