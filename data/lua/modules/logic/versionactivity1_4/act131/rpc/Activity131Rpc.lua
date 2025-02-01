module("modules.logic.versionactivity1_4.act131.rpc.Activity131Rpc", package.seeall)

slot0 = class("Activity131Rpc", BaseRpc)
slot0.instance = slot0.New()

function slot0.sendGet131InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity131Module_pb.Get131InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet131InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Model.instance:setInfos(slot2.infos)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnGetInfoSuccess)
end

function slot0.sendAct131StoryRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity131Module_pb.Act131StoryRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct131StoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Model.instance:updateProgress(slot2.episodeId, slot2.progress)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnStoryFinishedSuccess)
end

function slot0.sendAct131GeneralRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity131Module_pb.Act131GeneralRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.elementId = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct131GeneralReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnGeneralGameSuccess)
end

function slot0.sendAct131DialogRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity131Module_pb.Act131DialogRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	slot5.elementId = slot3
	slot5.option = slot4

	slot0:sendMsg(slot5)
end

function slot0.onReceiveAct131DialogReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnDialogMarkSuccess)
end

function slot0.sendAct131DialogHistoryRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity131Module_pb.Act131DialogHistoryRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2
	slot5.elementId = slot3

	for slot9, slot10 in ipairs(slot4) do
		table.insert(slot5.historylist, slot10)
	end

	slot0:sendMsg(slot5)
end

function slot0.onReceiveAct131DialogHistoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnDialogHistorySuccess)
end

function slot0.onReceiveAct131ElementsPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Model.instance:updateInfos(slot2.act131Info)
	Activity131Model.instance:refreshLogDics()
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnElementUpdate)
end

function slot0.sendAct131RestartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity131Module_pb.Act131RestartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct131RestartEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Model.instance:updateInfos(slot2.infos)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnRestartEpisodeSuccess)
end

function slot0.sendBeforeAct131BattleRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity131Module_pb.BeforeAct131BattleRequest()
	slot4.activityId = slot1
	slot4.episodeId = slot2
	slot4.elementId = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveBeforeAct131BattleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnBattleBeforeSucess, slot2.elementId)
end

slot0.instance = slot0.New()

return slot0
