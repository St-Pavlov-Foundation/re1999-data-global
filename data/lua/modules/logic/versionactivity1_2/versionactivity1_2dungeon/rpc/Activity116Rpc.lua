module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.rpc.Activity116Rpc", package.seeall)

slot0 = class("Activity116Rpc", BaseRpc)

function slot0.sendGet116InfosRequest(slot0)
	slot1 = Activity116Module_pb.Get116InfosRequest()
	slot1.activityId = VersionActivity1_2Enum.ActivityId.Building

	slot0:sendMsg(slot1)
end

function slot0.onReceiveGet116InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveGet116InfosReply(slot2)
	end
end

function slot0.onReceiveAct116InfoUpdatePush(slot0, slot1, slot2)
	VersionActivity1_2DungeonModel.instance:onReceiveAct116InfoUpdatePush(slot2)
end

function slot0.sendUpgradeElementRequest(slot0, slot1)
	slot2 = Activity116Module_pb.UpgradeElementRequest()
	slot2.activityId = VersionActivity1_2Enum.ActivityId.Building
	slot2.elementId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveUpgradeElementReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveUpgradeElementReply(slot2)
	end
end

function slot0.sendBuildTrapRequest(slot0, slot1)
	slot2 = Activity116Module_pb.BuildTrapRequest()
	slot2.activityId = VersionActivity1_2Enum.ActivityId.Building
	slot2.trapId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveBuildTrapReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveBuildTrapReply(slot2)
	end
end

function slot0.sendPutTrapRequest(slot0, slot1)
	slot2 = Activity116Module_pb.PutTrapRequest()
	slot2.activityId = VersionActivity1_2Enum.ActivityId.Building
	slot2.trapId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceivePutTrapReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity1_2DungeonModel.instance:onReceivePutTrapReply(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
