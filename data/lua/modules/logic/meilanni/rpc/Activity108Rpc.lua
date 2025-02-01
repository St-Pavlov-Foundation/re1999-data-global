module("modules.logic.meilanni.rpc.Activity108Rpc", package.seeall)

slot0 = class("Activity108Rpc", BaseRpc)

function slot0.sendGet108InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity108Module_pb.Get108InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet108InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	MeilanniModel.instance:updateMapList(slot2.infos)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.getInfo)
end

function slot0.sendResetMapRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity108Module_pb.ResetMapRequest()
	slot5.activityId = slot1
	slot5.mapId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveResetMapReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	MeilanniModel.instance:updateMapInfo(slot2.info)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.resetMap)
	MeilanniController.instance:statStart()
end

function slot0.sendDialogEventSelectRequest(slot0, slot1, slot2, slot3, slot4)
	slot0._selectEventId = slot2
	slot5 = Activity108Module_pb.DialogEventSelectRequest()
	slot5.activityId = slot1
	slot5.eventId = slot2

	for slot9, slot10 in ipairs(slot3) do
		table.insert(slot5.historylist, slot10)
	end

	slot5.option = slot4

	slot0:sendMsg(slot5)
end

function slot0.onReceiveDialogEventSelectReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.info

	if slot2:HasField("mapInfo") then
		slot5 = MeilanniModel.instance:getMapInfo(slot2.mapInfo.mapId)

		MeilanniModel.instance:updateMapExcludeRules(slot2.mapInfo)

		if #slot5:getExcludeRules() ~= #slot5:getExcludeRules() then
			MeilanniController.instance:dispatchEvent(MeilanniEvent.updateExcludeRules, {
				slot6,
				slot8,
				slot5:getThreat()
			})
		end
	end

	MeilanniModel.instance:updateEpisodeInfo(slot4)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.episodeInfoUpdate, slot0._selectEventId)
end

function slot0.sendEnterFightEventRequest(slot0, slot1, slot2)
	slot3 = Activity108Module_pb.EnterFightEventRequest()
	slot3.activityId = slot1
	slot3.eventId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveEnterFightEventReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	MeilanniController.instance:enterFight(slot2.eventId)
end

function slot0.sendEpisodeConfirmRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity108Module_pb.EpisodeConfirmRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveEpisodeConfirmReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.episodeId

	MeilanniController.instance:dispatchEvent(MeilanniEvent.episodeInfoUpdate)
end

function slot0.sendGet108BonusRequest(slot0, slot1, slot2)
	slot3 = Activity108Module_pb.Get108BonusRequest()
	slot3.activityId = slot1
	slot3.id = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGet108BonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId
	slot4 = slot2.id

	MeilanniController.instance:dispatchEvent(MeilanniEvent.bonusReply)
end

function slot0.onReceiveEpisodeUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	MeilanniModel.instance:updateEpisodeInfo(slot2.info)
end

function slot0.onReceiveInfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.activityId

	MeilanniModel.instance:updateMapList(slot2.infos)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.getInfo)
end

slot0.instance = slot0.New()

return slot0
