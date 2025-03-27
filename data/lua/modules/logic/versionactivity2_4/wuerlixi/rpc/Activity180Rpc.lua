module("modules.logic.versionactivity2_4.wuerlixi.rpc.Activity180Rpc", package.seeall)

slot0 = class("Activity180Rpc", BaseRpc)

function slot0.sendGet180InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity180Module_pb.Get180InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet180InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		WuErLiXiModel.instance:initInfos(slot2.act180EpisodeNO)
	end
end

function slot0.sendAct180EnterEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity180Module_pb.Act180EnterEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct180EnterEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		WuErLiXiModel.instance:updateEpisodeInfo(slot2.episode)
	end
end

function slot0.sendAct180StoryRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity180Module_pb.Act180StoryRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct180StoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		WuErLiXiModel.instance:updateEpisodeInfo(slot2.episode)
	end
end

function slot0.sendAct180GameFinishRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity180Module_pb.Act180GameFinishRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct180GameFinishReply(slot0, slot1, slot2)
	if slot1 == 0 then
		WuErLiXiModel.instance:updateEpisodeInfo(slot2.episode)
	end
end

function slot0.sendAct180SaveGameRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity180Module_pb.Act180SaveGameRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.gameData = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct180SaveGameReply(slot0, slot1, slot2)
	if slot1 == 0 then
		WuErLiXiModel.instance:updateEpisodeGameString(slot2.episodeId, slot2.gameData)
	end
end

function slot0.onReceiveAct180EpisodePush(slot0, slot1, slot2)
	if slot1 == 0 then
		WuErLiXiModel.instance:updateInfos(slot2.act180Episodes)
	end
end

slot0.instance = slot0.New()

return slot0
