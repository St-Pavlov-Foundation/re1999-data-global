module("modules.logic.versionactivity1_5.act146.model.Activity146Model", package.seeall)

slot0 = class("Activity146Model", BaseModel)
slot0.EpisodeUnFinishState = 0
slot0.EpisodeFinishedState = 1
slot0.EpisodeHasReceiveState = 2

function slot0.onInit(slot0)
	slot0._actInfo = nil
end

function slot0.reInit(slot0)
	slot0._actInfo = nil
end

function slot0.setActivityInfo(slot0, slot1)
	slot0._actInfo = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			if slot6.id and slot6.state then
				slot0._actInfo[slot6.id] = slot6.state
			end
		end
	end
end

function slot0.isEpisodeUnLockAndUnFinish(slot0, slot1)
	return slot0._actInfo and slot0._actInfo[slot1] == uv0.EpisodeUnFinishState
end

function slot0.isEpisodeFinishedButUnReceive(slot0, slot1)
	return slot0._actInfo and slot0._actInfo[slot1] == uv0.EpisodeFinishedState
end

function slot0.isEpisodeFinished(slot0, slot1)
	return slot0:isEpisodeFinishedButUnReceive(slot1) or slot0:isEpisodeHasReceivedReward(slot1)
end

function slot0.isEpisodeHasReceivedReward(slot0, slot1)
	return slot0._actInfo and slot0._actInfo[slot1] == uv0.EpisodeHasReceiveState
end

function slot0.isEpisodeUnLock(slot0, slot1)
	slot3 = true

	if Activity146Config.instance:getPreEpisodeConfig(ActivityEnum.Activity.Activity1_5WarmUp, slot1) then
		slot3 = slot0:isEpisodeFinished(slot2.id)
	end

	return slot3 and slot0._actInfo and slot0._actInfo[slot1] ~= nil
end

function slot0.isHasEpisodeCanReceiveReward(slot0)
	for slot5, slot6 in pairs(Activity146Config.instance:getAllEpisodeConfigs(ActivityEnum.Activity.Activity1_5WarmUp)) do
		if slot0:isEpisodeFinishedButUnReceive(slot6.id) then
			return true
		end
	end

	return false
end

function slot0.getActivityInfo(slot0)
	return slot0._actInfo
end

function slot0.isAllEpisodeFinish(slot0)
	if slot0._actInfo then
		for slot4, slot5 in pairs(slot0._actInfo) do
			if tonumber(slot5) == uv0.EpisodeUnFinishState then
				return false
			end
		end

		return true
	end

	return false
end

function slot0.setCurSelectedEpisode(slot0, slot1)
	slot0._curSelectedEpisodeId = slot1
end

function slot0.getCurSelectedEpisode(slot0)
	return slot0._curSelectedEpisodeId
end

function slot0.markHasEnterEpisode(slot0, slot1)
	if not slot0._hasEnterEpisodeDict then
		slot0:decodeHasEnterEpisodeData()
	end

	slot2 = false

	if not slot0._hasEnterEpisodeDict[slot1] then
		slot0._hasEnterEpisodeDict[slot1] = true

		table.insert(slot0._hasEnterEpisodeList, slot1)

		slot2 = true
	end

	if slot2 then
		slot0:flushHasEnterEpisodes()
	end
end

function slot0.flushHasEnterEpisodes(slot0)
	if slot0._hasEnterEpisodeList then
		PlayerPrefsHelper.setString(slot0:getLocalKey(), cjson.encode(slot0._hasEnterEpisodeList))
	end
end

function slot0.isEpisodeFirstEnter(slot0, slot1)
	if not slot0._hasEnterEpisodeDict then
		slot0:decodeHasEnterEpisodeData()
	end

	return not slot0._hasEnterEpisodeDict[slot1]
end

function slot0.decodeHasEnterEpisodeData(slot0)
	slot2 = nil

	if not string.nilorempty(slot0:getLocalKey()) then
		slot2 = PlayerPrefsHelper.getString(slot1, "")
	end

	slot0._hasEnterEpisodeDict = {}

	if not string.nilorempty(slot2) then
		slot0._hasEnterEpisodeList = cjson.decode(slot2)

		for slot6, slot7 in pairs(slot0._hasEnterEpisodeList) do
			slot0._hasEnterEpisodeDict[slot7] = true
		end
	else
		slot0._hasEnterEpisodeList = {}
	end
end

function slot0.getLocalKey(slot0)
	return PlayerPrefsKey.Version1_5_Act146HasEnterEpisodeKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

slot0.instance = slot0.New()

return slot0
