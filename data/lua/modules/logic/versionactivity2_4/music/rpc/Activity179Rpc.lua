module("modules.logic.versionactivity2_4.music.rpc.Activity179Rpc", package.seeall)

slot0 = class("Activity179Rpc", BaseRpc)

function slot0.sendGet179InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity179Module_pb.Get179InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet179InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	Activity179Model.instance:initEpisodeList(slot2.act179EpisodeNO)
end

function slot0.sendSet179ScoreRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity179Module_pb.Set179ScoreRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.score = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveSet179ScoreReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	Activity179Model.instance:updateEpisode(slot2.act179EpisodeNO)
end

slot0.instance = slot0.New()

return slot0
