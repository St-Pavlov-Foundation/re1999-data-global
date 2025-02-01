module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.rpc.Activity121Rpc", package.seeall)

slot0 = class("Activity121Rpc", BaseRpc)

function slot0.sendGet121InfosRequest(slot0)
	slot1 = Activity121Module_pb.Get121InfosRequest()
	slot1.activityId = VersionActivityEnum.ActivityId.Act121

	slot0:sendMsg(slot1)
end

function slot0.onReceiveGet121InfosReply(slot0, slot1, slot2)
	VersionActivity1_2NoteModel.instance:onReceiveGet121InfosReply(slot1, slot2)
end

function slot0.sendGet121BonusRequest(slot0, slot1)
	slot2 = Activity121Module_pb.Get121BonusRequest()
	slot2.activityId = VersionActivityEnum.ActivityId.Act121
	slot2.storyId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGet121BonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity1_2NoteModel.instance:onReceiveGet121BonusReply(slot2)
	end
end

function slot0.onReceiveAct121UpdatePush(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity1_2NoteModel.instance:onReceiveAct121UpdatePush(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
