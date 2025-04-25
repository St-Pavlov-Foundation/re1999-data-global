module("modules.logic.versionactivity2_5.liangyue.rpc.LiangYueRpc", package.seeall)

slot0 = class("LiangYueRpc", BaseRpc)

function slot0.sendGetAct184InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity184Module_pb.GetAct184InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct184InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.episodes

	LiangYueModel.instance:onGetActInfo(slot2)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnReceiveEpisodeInfo)
end

function slot0.sendAct184FinishEpisodeRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity184Module_pb.Act184FinishEpisodeRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.puzzle = slot3 or ""

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct184FinishEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	LiangYueModel.instance:setEpisodeInfo(slot2)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnFinishEpisode, slot2.activityId, slot2.episodeId)
end

function slot0.onReceiveAct184EpisodePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.episodes

	LiangYueModel.instance:onActInfoPush(slot2)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeInfoPush)
end

slot0.instance = slot0.New()

return slot0
