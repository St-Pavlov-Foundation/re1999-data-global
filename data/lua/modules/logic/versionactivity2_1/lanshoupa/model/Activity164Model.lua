module("modules.logic.versionactivity2_1.lanshoupa.model.Activity164Model", package.seeall)

slot0 = class("Activity164Model", BaseModel)

function slot0.onInit(slot0)
	slot0._passEpisodes = {}
	slot0._unLockCount = 0
	slot0._curActivityId = 0
	slot0.currChessGameEpisodeId = 0
end

function slot0.reInit(slot0)
	slot0._passEpisodes = {}
	slot0._unLockCount = 0
	slot0._curActivityId = 0
	slot0.currChessGameEpisodeId = 0
end

function slot0.getCurActivityID(slot0)
	return slot0._curActivityId
end

function slot0.onReceiveGetAct164InfoReply(slot0, slot1)
	slot0._curActivityId = slot1.activityId
	slot0._passEpisodes = {}
	slot0._unLockCount = 0
	slot0.currChessGameEpisodeId = slot1.currChessGameEpisodeId

	for slot5, slot6 in ipairs(slot1.episodes) do
		if Activity164Config.instance:getEpisodeCo(slot1.activityId, slot6.episodeId) and slot8.mapIds <= 0 then
			slot0._passEpisodes[slot7] = StoryModel.instance:isStoryFinished(slot8.storyBefore)
		else
			slot0._passEpisodes[slot7] = slot6.passChessGame
		end

		if slot0._passEpisodes[slot7] then
			slot0._unLockCount = slot0._unLockCount + 1
		else
			break
		end
	end
end

function slot0.markEpisodeFinish(slot0, slot1)
	if not slot0._passEpisodes[slot1] then
		slot0._passEpisodes[slot1] = true
		slot0._unLockCount = slot0._unLockCount + 1

		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.OnEpisodeFinish, slot0._episodeId)
	end
end

function slot0.getUnlockCount(slot0)
	return slot0._unLockCount
end

function slot0.getEpisodeData(slot0, slot1)
	return slot0._passEpisodes[slot1]
end

function slot0.isEpisodeClear(slot0, slot1)
	if slot0:getEpisodeData(slot1) then
		return true
	end

	return false
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId or LanShouPaEnum.episodeId
end

slot0.instance = slot0.New()

return slot0
