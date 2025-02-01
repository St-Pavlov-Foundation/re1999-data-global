module("modules.logic.versionactivity.rpc.Activity112Rpc", package.seeall)

slot0 = class("Activity112Rpc", BaseRpc)

function slot0.sendGet112InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity112Module_pb.Get112InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet112InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity112Model.instance:updateInfo(slot2)
	end
end

function slot0.sendExchange112Request(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity112Module_pb.Exchange112Request()
	slot5.activityId = slot1
	slot5.id = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveExchange112Reply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity112Model.instance:updateRewardState(slot2.activityId, slot2.id)
	end
end

function slot0.onReceiveAct112TaskPush(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity112TaskListModel.instance:updateTaskInfo(slot2.activityId, slot2.act112Tasks)
	end
end

function slot0.sendReceiveAct112TaskRewardRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity112Module_pb.ReceiveAct112TaskRewardRequest()
	slot5.activityId = slot1
	slot5.taskId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveReceiveAct112TaskRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		VersionActivity112TaskListModel.instance:setGetBonus(slot2.activityId, slot2.taskId)
	end
end

slot0.instance = slot0.New()

return slot0
