module("modules.logic.versionactivity1_3.act125.model.Activity125MO", package.seeall)

slot0 = pureTable("Activity125MO")

function slot0.ctor(slot0)
	slot0._userId = PlayerModel.instance:getMyUserId()
	slot0._episdoeInfos = {}
	slot0._oldDict = {}
end

function slot0.setInfo(slot0, slot1)
	slot0._episdoeInfos = {}
	slot0.id = slot1.activityId

	slot0:initConfig()
	slot0:updateInfo(slot1.act125Episodes)
end

function slot0.initConfig(slot0)
	if slot0.config then
		return
	end

	slot0.config = Activity125Config.instance:getAct125Config(slot0.id)
	slot0._episodeList = {}

	if slot0.config then
		for slot4, slot5 in pairs(slot0.config) do
			table.insert(slot0._episodeList, slot5)
		end

		table.sort(slot0._episodeList, SortUtil.keyLower("id"))
	end
end

function slot0.updateInfo(slot0, slot1)
	if slot1 then
		for slot5 = 1, #slot1 do
			slot6 = slot1[slot5]
			slot0._episdoeInfos[slot6.id] = slot6.state
		end
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(ActivityConfig.instance:getActivityCo(slot0.id).redDotId)] = true
	})
end

function slot0.isEpisodeFinished(slot0, slot1)
	return slot0._episdoeInfos and slot0._episdoeInfos[slot1] == 1
end

function slot0.getEpisodeConfig(slot0, slot1)
	return slot0.config[slot1]
end

function slot0.isEpisodeUnLock(slot0, slot1)
	slot4 = true

	if slot0:getEpisodeConfig(slot1).preId and slot3 > 0 then
		slot4 = slot0._episdoeInfos[slot3] == 1 or slot0:checkLocalIsPlay(slot3) and slot0._episdoeInfos[slot3] == 0
	end

	return slot4 and slot0._episdoeInfos[slot1] ~= nil
end

function slot0.isEpisodeDayOpen(slot0, slot1, slot2)
	slot3 = false
	slot6 = slot0:getEpisodeConfig(slot1).openDay
	slot7 = 0
	slot8 = 0

	if ActivityModel.instance:getActMO(slot0.id) and slot6 then
		slot10 = ServerTime.now()

		if slot4:getRealStartTimeStamp() + (slot6 - 1) * TimeUtil.OneDaySecond - ServerTime.now() < 0 then
			slot3 = true
		else
			slot7 = math.floor(slot8 / TimeUtil.OneDaySecond)
		end
	end

	return slot3, slot7, slot8
end

function slot0.isEpisodeReallyOpen(slot0, slot1)
	slot2 = slot0:isEpisodeUnLock(slot1)
	slot3 = slot0:isEpisodeDayOpen(slot1)

	if (slot0:getEpisodeConfig(slot1) and slot4.preId or nil) and slot5 > 0 and not slot0:isEpisodeFinished(slot5) then
		return false
	end

	return slot2 and slot3
end

function slot0.getLastEpisode(slot0)
	for slot4 = #slot0._episodeList, 1, -1 do
		if slot0:isEpisodeReallyOpen(slot0._episodeList[slot4].id) then
			return slot5.id
		end
	end

	return slot0._episodeList[1] and slot1.id
end

function slot0.getFirstRewardEpisode(slot0)
	for slot4, slot5 in ipairs(slot0._episodeList) do
		if slot0:isEpisodeReallyOpen(slot5.id) then
			if slot0._episdoeInfos[slot5.id] == 0 then
				return slot5.id
			end
		else
			return slot5.preId
		end
	end

	return slot0._episodeList[#slot0._episodeList] and slot1.id
end

function slot0.setLocalIsPlay(slot0, slot1)
	PlayerPrefsHelper.setString(string.format("%s_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, PlayerPrefsKey.VersionActivityWarmUpView, slot0.id, slot1), 1)
end

function slot0.checkLocalIsPlay(slot0, slot1)
	if string.nilorempty(PlayerPrefsHelper.getString(string.format("%s_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, PlayerPrefsKey.VersionActivityWarmUpView, slot0.id, slot1), "")) then
		return false
	end

	return true
end

function slot0.setOldEpisode(slot0, slot1)
	slot0._oldDict[slot1] = true
end

function slot0.checkIsOldEpisode(slot0, slot1)
	return slot0._oldDict[slot1]
end

function slot0.getEpisodeCount(slot0)
	return #slot0._episodeList
end

function slot0.getEpisodeList(slot0)
	return slot0._episodeList
end

function slot0.setSelectEpisodeId(slot0, slot1)
	slot0._selectId = slot1
end

function slot0.getSelectEpisodeId(slot0)
	if not slot0._selectId then
		slot0._selectId = slot0:getFirstRewardEpisode()
	end

	return slot0._selectId
end

function slot0.isAllEpisodeFinish(slot0)
	for slot4, slot5 in ipairs(slot0._episodeList) do
		if not slot0._episdoeInfos[slot5.id] or slot6 == 0 then
			return false
		end
	end

	return true
end

function slot0.isHasEpisodeCanReceiveReward(slot0, slot1)
	if slot1 then
		return slot0._episdoeInfos[slot1] == 0
	end

	for slot5, slot6 in ipairs(slot0._episodeList) do
		if slot0._episdoeInfos[slot6.id] == 0 then
			return true
		end
	end

	return false
end

function slot0.isFirstCheckEpisode(slot0, slot1)
	return PlayerPrefsHelper.getNumber(string.format("%s_%s_%s_%s", slot0._userId, PlayerPrefsKey.Activity125FirstCheckEpisode, slot0.id, slot1), 0) == 0
end

function slot0.setHasCheckEpisode(slot0, slot1)
	if slot0:isFirstCheckEpisode(slot1) then
		PlayerPrefsHelper.setNumber(string.format("%s_%s_%s_%s", slot0._userId, PlayerPrefsKey.Activity125FirstCheckEpisode, slot0.id, slot1), 1)
	end
end

function slot0.hasEpisodeCanCheck(slot0)
	for slot4, slot5 in ipairs(slot0._episodeList) do
		if slot0:isEpisodeReallyOpen(slot5.id) and slot0:isFirstCheckEpisode(slot6) then
			return true
		end
	end

	return false
end

function slot0.hasEpisodeCanGetReward(slot0)
	for slot4, slot5 in ipairs(slot0._episodeList) do
		if slot0._episdoeInfos[slot5.id] == 0 and slot0:checkLocalIsPlay(slot5.id) then
			return true
		end
	end

	return false
end

function slot0.getRLOC(slot0, slot1)
	slot3 = slot0:checkLocalIsPlay(slot1)

	return slot2, slot3, slot0:checkIsOldEpisode(slot1), not slot0:isEpisodeFinished(slot1) and slot3
end

function slot0.hasRedDot(slot0)
	for slot4, slot5 in ipairs(slot0._episodeList) do
		if slot0:isEpisodeReallyOpen(slot5.id) and slot0:isHasEpisodeCanReceiveReward(slot6) then
			return true
		end
	end

	return false
end

return slot0
