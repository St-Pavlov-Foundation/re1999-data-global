module("modules.logic.versionactivity1_5.act142.model.Activity142Model", package.seeall)

slot0 = class("Activity142Model", BaseModel)
slot1 = 1

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0._activityId = nil
	slot0._curEpisodeId = nil
	slot0._episodeInfoData = {}
	slot0._hasCollectionDict = {}

	slot0:clearCacheData()
end

function slot0.onReceiveGetAct142InfoReply(slot0, slot1)
	slot0._activityId = slot1.activityId
	slot0._episodeInfoData = {}

	for slot5, slot6 in ipairs(slot1.episodes) do
		slot7 = slot6.id
		slot0._episodeInfoData[slot7] = {
			id = slot6.id,
			star = slot6.star,
			totalCount = slot6.totalCount
		}
	end
end

function slot0.getRemainTimeStr(slot0, slot1)
	slot2 = ""

	return (not ActivityModel.instance:getActMO(slot1) or string.format(luaLang("remain"), slot3:getRemainTimeStr3())) and string.format(luaLang("activity_warmup_remain_time"), "0")
end

function slot0.getActivityId(slot0)
	return slot0._activityId or VersionActivity1_5Enum.ActivityId.Activity142
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId or uv0
end

function slot0.getEpisodeData(slot0, slot1)
	slot2 = nil

	if slot0._episodeInfoData then
		slot2 = slot0._episodeInfoData[slot1]
	end

	return slot2
end

function slot0.isEpisodeClear(slot0, slot1)
	slot2 = false

	if slot0:getEpisodeData(slot1) then
		slot2 = slot3.star > 0
	end

	return slot2
end

function slot0.isOpenDay(slot0, slot1, slot2)
	slot3 = false
	slot5 = Activity142Config.instance:getEpisodeOpenDay(slot1, slot2)

	if ActivityModel.instance:getActMO(slot1) and slot5 and slot4:getRealStartTimeStamp() + (slot5 - 1) * TimeUtil.OneDaySecond < ServerTime.now() then
		slot3 = true
	end

	return slot3
end

function slot0.isPreEpisodeClear(slot0, slot1, slot2)
	slot3 = false

	return Activity142Config.instance:getEpisodePreEpisode(slot1, slot2) == 0 and true or slot0:isEpisodeClear(slot4)
end

function slot0.isEpisodeOpen(slot0, slot1, slot2)
	return slot0:isPreEpisodeClear(slot1, slot2) and slot0:isOpenDay(slot1, slot2)
end

function slot0.onReceiveAct142StartEpisodeReply(slot0, slot1)
	slot0:increaseCount(slot1.map.id)
end

function slot0.increaseCount(slot0, slot1)
	if slot0._episodeInfoData and slot0._episodeInfoData[slot1] then
		slot2.totalCount = slot2.totalCount + 1
	end
end

function slot0.setHasCollection(slot0, slot1)
	if not slot0._hasCollectionDict then
		slot0._hasCollectionDict = {}
	end

	slot0._hasCollectionDict[slot1] = true
end

function slot0.getHadCollectionCount(slot0)
	for slot7, slot8 in ipairs(Activity142Config.instance:getCollectionList(slot0:getActivityId())) do
		if slot0:isHasCollection(slot8) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getHadCollectionIdList(slot0)
	slot1 = {}

	for slot7, slot8 in ipairs(Activity142Config.instance:getCollectionList(slot0:getActivityId())) do
		if slot0:isHasCollection(slot8) then
			slot1[#slot1 + 1] = slot8
		end
	end

	return slot1
end

function slot0.isHasCollection(slot0, slot1)
	slot2 = false

	if slot0._hasCollectionDict and slot0._hasCollectionDict[slot1] then
		slot2 = true
	end

	return slot2
end

function slot0.getPlayerCacheData(slot0)
	if not PlayerModel.instance:getMyUserId() or slot1 == 0 then
		return
	end

	if not slot0.cacheData then
		if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.Version1_5_Act142ChessKey, "")) then
			slot0.cacheData = cjson.decode(slot3)
			slot0.playerCacheData = slot0.cacheData[tostring(slot1)]
		end

		if not slot0.cacheData then
			slot4 = {}
		end

		slot0.cacheData = slot4
	end

	if not slot0.playerCacheData then
		slot0.playerCacheData = {}
		slot0.cacheData[slot2] = slot0.playerCacheData

		slot0:saveCacheData()
	end

	return slot0.playerCacheData
end

function slot0.saveCacheData(slot0)
	if not slot0.cacheData then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.Version1_5_Act142ChessKey, cjson.encode(slot0.cacheData))
end

function slot0.clearCacheData(slot0)
	slot0.cacheData = nil
	slot0.playerCacheData = nil
end

function slot0.getStarCount(slot0)
	slot3 = Va3ChessModel.instance:getEpisodeId()

	if not Va3ChessGameModel.instance:getActId() or not slot3 then
		return 0
	end

	if not Va3ChessConfig.instance:getEpisodeCo(slot2, slot3) then
		return slot1
	end

	if Activity142Helper.checkConditionIsFinish(slot4.mainConfition, slot2) then
		slot1 = slot1 + 1
	end

	if Activity142Helper.checkConditionIsFinish(slot4.extStarCondition, slot2) then
		slot1 = slot1 + 1
	end

	return slot1
end

function slot0.isChapterOpen(slot0, slot1)
	slot2 = false

	if Activity142Config.instance:getChapterEpisodeIdList(slot0:getActivityId(), slot1) and slot4[1] then
		slot2 = slot0:isEpisodeOpen(slot3, slot5)
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
