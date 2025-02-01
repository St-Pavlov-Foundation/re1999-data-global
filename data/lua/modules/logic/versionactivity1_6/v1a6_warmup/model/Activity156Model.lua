module("modules.logic.versionactivity1_6.v1a6_warmup.model.Activity156Model", package.seeall)

slot0 = class("Activity156Model", BaseModel)
slot0.EpisodeUnFinishState = 0
slot0.EpisodeFinishedState = 1

function slot0.onInit(slot0)
	slot0._actInfo = nil
end

function slot0.reInit(slot0)
	slot0._actInfo = nil
end

function slot0.setActivityInfo(slot0, slot1)
	slot0._actInfo = {}

	for slot5, slot6 in pairs(slot1) do
		if slot6.id and slot6.state then
			slot0._actInfo[slot6.id] = slot6.state
		end
	end
end

function slot0.setLocalIsPlay(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. PlayerPrefsKey.VersionActivity1_6WarmUpView .. slot1, slot1)
end

function slot0.checkLocalIsPlay(slot0, slot1)
	if string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. PlayerPrefsKey.VersionActivity1_6WarmUpView .. slot1, "")) then
		return false
	end

	return true
end

function slot0.isEpisodeFinishedButUnReceive(slot0, slot1)
	return slot0._actInfo and slot0._actInfo[slot1] == uv0.EpisodeFinishedState
end

function slot0.isEpisodeFinished(slot0, slot1)
	return slot0:isEpisodeFinishedButUnReceive(slot1) or slot0:isEpisodeHasReceivedReward(slot1)
end

function slot0.isEpisodeHasReceivedReward(slot0, slot1)
	return slot0._actInfo and slot0._actInfo[slot1] == uv0.EpisodeFinishedState
end

function slot0.setCurSelectedEpisode(slot0, slot1)
	slot0._curSelectedEpisodeId = slot1
end

function slot0.getCurSelectedEpisode(slot0)
	return slot0._curSelectedEpisodeId
end

function slot0.cleanCurSelectedEpisode(slot0)
	slot0._curSelectedEpisodeId = nil
end

function slot0.setIsPlayingMusicId(slot0, slot1)
	slot0._isPlayingMusicId = slot1
end

function slot0.checkIsPlayingMusicId(slot0, slot1)
	if slot0._isPlayingMusicId == slot1 then
		return true
	end

	return false
end

function slot0.cleanIsPlayingMusicId(slot0)
	slot0._isPlayingMusicId = nil
end

function slot0.isEpisodeUnLock(slot0, slot1)
	slot3 = true

	if Activity156Config.instance:getPreEpisodeConfig(slot1) then
		slot3 = slot0:isEpisodeFinished(slot2.id)
	end

	return slot3 and slot0._actInfo and slot0._actInfo[slot1] ~= nil
end

function slot0.isOpen(slot0, slot1, slot2)
	slot3 = false
	slot5 = Activity156Config.instance:getEpisodeOpenDay(slot2)

	if ActivityModel.instance:getActMO(slot1) and slot5 then
		slot7 = ServerTime.now()

		if slot4:getRealStartTimeStamp() + (slot5 - 1) * TimeUtil.OneDaySecond < ServerTime.now() then
			slot3 = true
		end
	end

	return slot3
end

function slot0.reallyOpen(slot0, slot1, slot2)
	return slot0:isEpisodeUnLock(slot2) and slot0:isOpen(slot1, slot2)
end

function slot0.getLastEpisode(slot0)
	if slot0._actInfo then
		for slot4, slot5 in ipairs(slot0._actInfo) do
			if slot0:reallyOpen(ActivityEnum.Activity.Activity1_6WarmUp, slot4) then
				if slot5 == uv0.EpisodeUnFinishState then
					return slot4
				end
			else
				return slot4 - 1
			end
		end

		return #slot0._actInfo
	end
end

function slot0.getActivityInfo(slot0)
	return slot0._actInfo
end

function slot0.isAllEpisodeFinish(slot0)
	if slot0._actInfo then
		for slot4, slot5 in pairs(slot0._actInfo) do
			if tonumber(slot5) == 0 then
				return false
			end
		end

		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
