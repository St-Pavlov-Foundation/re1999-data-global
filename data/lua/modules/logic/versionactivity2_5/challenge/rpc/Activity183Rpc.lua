module("modules.logic.versionactivity2_5.challenge.rpc.Activity183Rpc", package.seeall)

slot0 = class("Activity183Rpc", BaseRpc)

function slot0.sendAct183GetInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity183Module_pb.Act183GetInfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct183GetInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Act183Model.instance:init(slot2.activityId, slot2.actInfo)
end

function slot0.sendAct183ResetGroupRequest(slot0, slot1, slot2)
	slot3 = Activity183Module_pb.Act183ResetGroupRequest()
	slot3.activityId = slot1
	slot3.groupId = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveAct183ResetGroupReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Act183Controller.instance:updateResetGroupEpisodeInfo(slot2.activityId, slot2.group)
end

function slot0.sendAct183ResetEpisodeRequest(slot0, slot1, slot2)
	slot3 = Activity183Module_pb.Act183ResetEpisodeRequest()
	slot3.activityId = slot1
	slot3.episodeId = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveAct183ResetEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Act183Controller.instance:updateResetEpisodeInfo(slot2.group)
end

function slot0.sendAct183ChooseRepressRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = Activity183Module_pb.Act183ChooseRepressRequest()
	slot7.activityId = slot1
	slot7.episodeId = slot2
	slot7.ruleIndex = slot3
	slot7.heroIndex = slot4

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveAct183ChooseRepressReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Act183Controller.instance:updateChooseRepressInfo(slot2.episodeId, slot2.repress)
end

function slot0.sendAct183GetRecordRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity183Module_pb.Act183GetRecordRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct183GetRecordReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	Act183ReportListModel.instance:init(slot3, Act183Helper.rpcInfosToList(slot2.groupList, Act183GroupEpisodeRecordMO, slot3))
end

function slot0.sendAct183ReplaceResultRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity183Module_pb.Act183ReplaceResultRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct183ReplaceResultReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if Act183Model.instance:getEpisodeMo(slot2.activityId, slot2.episode.episodeId) then
		slot6:init(slot4)
	end
end

function slot0.onReceiveAct183BadgeNumUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	Act183Model.instance:getActInfo():updateBadgeNum(slot2.badgeNum)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeNum)
	Act183Controller.instance:dispatchEvent(Act183Event.RefreshMedalReddot)
end

function slot0.onReceiveAct183BattleFinishPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = nil

	Act183EpisodeMO.New():init(slot2.episode)

	slot5 = nil

	if slot2:HasField("fightResult") then
		Act183FightResultMO.New():init(slot2.fightResult)
	end

	slot6 = nil

	if slot2:HasField("record") then
		Act183GroupEpisodeRecordMO.New():init(slot2.record)
	end

	Act183Model.instance:recordBattleFinishedInfo({
		activityId = slot3,
		episodeMo = slot4,
		groupFinished = slot2.groupFinished,
		win = slot2.win,
		record = slot6,
		reChallenge = slot2.reChallenge,
		fightResultMo = slot5,
		params = slot2.params
	})
end

slot0.instance = slot0.New()

return slot0
