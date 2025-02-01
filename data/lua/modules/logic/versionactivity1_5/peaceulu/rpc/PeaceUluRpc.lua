module("modules.logic.versionactivity1_5.peaceulu.rpc.PeaceUluRpc", package.seeall)

slot0 = class("PeaceUluRpc", BaseRpc)

function slot0.sendGet145InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity145Module_pb.Get145InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet145InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(slot2.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function slot0.onReceiveAct145InfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(slot2.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function slot0.sendAct145RemoveTaskRequest(slot0, slot1, slot2)
	slot3 = Activity145Module_pb.Act145RemoveTaskRequest()
	slot3.activityId = slot1
	slot3.taskId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct145RemoveTaskReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PeaceUluModel.instance:onGetRemoveTask(slot2)
end

function slot0.sendAct145GameRequest(slot0, slot1, slot2)
	slot3 = Activity145Module_pb.Act145GameRequest()
	slot3.activityId = slot1
	slot3.content = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct145GameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PeaceUluModel.instance:onGetGameResult(slot2)
end

function slot0.sendAct145GetRewardsRequest(slot0, slot1)
	slot2 = Activity145Module_pb.Act145GetRewardsRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct145GetRewardsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PeaceUluModel.instance:onUpdateReward(slot2)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function slot0.sendAct145ClearGameRecordRequest(slot0, slot1)
	slot2 = Activity145Module_pb.Act145ClearGameRecordRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct145ClearGameRecordReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(slot2.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

slot0.instance = slot0.New()

return slot0
