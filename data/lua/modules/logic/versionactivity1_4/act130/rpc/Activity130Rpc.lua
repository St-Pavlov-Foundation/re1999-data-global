module("modules.logic.versionactivity1_4.act130.rpc.Activity130Rpc", package.seeall)

slot0 = class("Activity130Rpc", BaseRpc)
slot0.instance = slot0.New()

function slot0.sendGet130InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity130Module_pb.Get130InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet130InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Model.instance:setInfos(slot2.infos)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnGetInfoSuccess)
end

function slot0.sendAct130StoryRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity130Module_pb.Act130StoryRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct130StoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Model.instance:updateProgress(slot2.episodeId, slot2.progress)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnStoryFinishedSuccess)
end

function slot0.sendAct130GeneralRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity130Module_pb.Act130GeneralRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.elementId = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct130GeneralReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnGeneralGameSuccess)
end

function slot0.sendAct130DialogRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity130Module_pb.Act130DialogRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	slot5.elementId = slot3
	slot5.option = slot4

	slot0:sendMsg(slot5)
end

function slot0.onReceiveAct130DialogReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnDialogMarkSuccess, slot2.elementId)
end

function slot0.sendAct130DialogHistoryRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity130Module_pb.Act130DialogHistoryRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	slot5.elementId = slot3

	for slot9, slot10 in ipairs(slot4) do
		table.insert(slot5.historylist, slot10)
	end

	slot0:sendMsg(slot5)
end

function slot0.onReceiveAct130DialogHistoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnDialogHistorySuccess)
end

function slot0.onReceiveAct130ElementsPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Model.instance:updateInfos(slot2.act130Info)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnElementUpdate)
end

function slot0.sendAct130RestartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity130Module_pb.Act130RestartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct130RestartEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Model.instance:updateInfos(slot2.infos)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnRestartEpisodeSuccess)
end

function slot0.addGameChallengeNum(slot0, slot1)
	slot2 = Activity130Module_pb.Act130StartGameRequest()
	slot2.activityId = VersionActivity1_4Enum.ActivityId.Role37
	slot2.episodeId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct130StartGameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity130Model.instance:updateChallengeNum(slot2.episodeId, slot2.startGameTimes)
end

slot0.instance = slot0.New()

return slot0
