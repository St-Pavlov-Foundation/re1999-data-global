module("modules.logic.pushbox.rpc.PushBoxRpc", package.seeall)

slot0 = class("PushBoxRpc", BaseRpc)

function slot0.sendGet111InfosRequest(slot0, slot1, slot2)
	slot3 = Activity111Module_pb.Get111InfosRequest()
	slot3.activityId = 11113

	slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveGet111InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PushBoxModel.instance:onReceiveGet111InfosReply(slot2)
	end
end

function slot0.sendFinishEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity111Module_pb.FinishEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	slot5.step = slot3
	slot5.alarm = slot4

	for slot10 = 1, 6 do
		slot6 = ServerTime.now() .. math.random(0, 9)
	end

	slot5.timestamp = slot6
	slot5.sign = GameLuaMD5.sumhexa(string.format("%s#%s#%s#%s#%s#%s", slot1, slot2, slot3, slot4, slot6, LoginModel.instance.sessionId))

	slot0:sendMsg(slot5)
end

function slot0.onReceiveFinishEpisodeReply(slot0, slot1, slot2)
	PushBoxModel.instance:onReceiveFinishEpisodeReply(slot1, slot2)
end

function slot0.onReceiveAct111InfoPush(slot0, slot1, slot2)
	PushBoxModel.instance:onReceiveAct111InfoPush(slot2)
end

function slot0.onReceivePushBoxTaskPush(slot0, slot1, slot2)
	PushBoxModel.instance:onReceivePushBoxTaskPush(slot2)
end

function slot0.sendReceiveTaskRewardRequest(slot0, slot1, slot2)
	slot3 = Activity111Module_pb.ReceiveTaskRewardRequest()
	slot3.activityId = slot1 or PushBoxModel.instance:getCurActivityID()
	slot3.taskId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveReceiveTaskRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PushBoxModel.instance:onReceiveReceiveTaskRewardReply(slot2)
	end
end

setGlobal("Activity111Rpc", slot0)

slot0.instance = slot0.New()

return slot0
