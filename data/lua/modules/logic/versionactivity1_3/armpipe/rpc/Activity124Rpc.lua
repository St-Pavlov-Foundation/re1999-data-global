module("modules.logic.versionactivity1_3.armpipe.rpc.Activity124Rpc", package.seeall)

slot0 = class("Activity124Rpc", BaseRpc)

function slot0.sendGetAct124InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity124Module_pb.GetAct124InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct124InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity124Model.instance:onReceiveGetAct120InfoReply(slot2)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshMapData)
	end
end

function slot0.sendFinishAct124EpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity124Module_pb.FinishAct124EpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	slot5.timestamp = slot3 or ""
	slot5.sign = slot4 or ""

	slot0:sendMsg(slot5)
end

function slot0.onReceiveFinishAct124EpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity124Model.instance:onReceiveFinishAct124EpisodeReply(slot2)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshEpisode, slot2.episodeId)
	end
end

function slot0.sendReceiveAct124RewardRequest(slot0, slot1, slot2)
	slot3 = Activity124Module_pb.ReceiveAct124RewardRequest()
	slot3.activityId = slot1
	slot3.episodeId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveReceiveAct124RewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity124Model.instance:onReceiveReceiveAct124RewardReply(slot2)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshReceiveReward, slot2.episodeId)
	end
end

slot0.instance = slot0.New()

return slot0
