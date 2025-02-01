module("modules.logic.versionactivity1_3.armpipe.model.Activity124Model", package.seeall)

slot0 = class("Activity124Model", BaseModel)

function slot0.onInit(slot0)
	slot0._episodeInfoDict = {}
end

function slot0.reInit(slot0)
	slot0._episodeInfoDict = {}
end

function slot0.getCurActivityID(slot0)
	return slot0._curActivityId
end

function slot0.onReceiveGetAct120InfoReply(slot0, slot1)
	slot0._curActivityId = slot1.activityId
	slot0._episodeInfoDict[slot1.activityId] = {}

	slot0:_updateEpisodeInfo(slot0._curActivityId, slot1.act124Episodes)
end

function slot0.onReceiveFinishAct124EpisodeReply(slot0, slot1)
	slot0:_updateEpisodeInfo(slot1.activityId, slot1.updateAct124Episodes)
end

function slot0.onReceiveReceiveAct124RewardReply(slot0, slot1)
	if slot0:getEpisodeData(slot1.activityId, slot1.episodeId) then
		slot4.state = ArmPuzzlePipeEnum.EpisodeState.Received
	end
end

function slot0._updateEpisodeInfo(slot0, slot1, slot2)
	if not slot0._episodeInfoDict[slot1] then
		slot0._episodeInfoDict[slot1] = {}
	end

	for slot7, slot8 in ipairs(slot2) do
		slot3[slot9] = slot3[slot8.id] or {}
		slot3[slot9].id = slot8.id
		slot3[slot9].state = slot8.state
	end
end

function slot0.getEpisodeData(slot0, slot1, slot2)
	return slot0._episodeInfoDict[slot1] and slot0._episodeInfoDict[slot1][slot2]
end

function slot0.isEpisodeOpenById(slot0, slot1, slot2)
	return ArmPuzzleHelper.isOpenDay(slot2)
end

function slot0.isEpisodeClear(slot0, slot1, slot2)
	if slot0:getEpisodeData(slot1, slot2) then
		return slot3.state == ArmPuzzlePipeEnum.EpisodeState.Finish or slot3.state == ArmPuzzlePipeEnum.EpisodeState.Received
	end

	return false
end

function slot0.isHasReard(slot0, slot1, slot2)
	if slot0:getEpisodeData(slot1, slot2) then
		return slot3.state == ArmPuzzlePipeEnum.EpisodeState.Finish
	end

	return false
end

function slot0.isReceived(slot0, slot1, slot2)
	if slot0:getEpisodeData(slot1, slot2) then
		return slot3.state == ArmPuzzlePipeEnum.EpisodeState.Received
	end

	return false
end

slot0.instance = slot0.New()

return slot0
