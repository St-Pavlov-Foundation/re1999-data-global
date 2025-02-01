module("modules.logic.versionactivity1_3.chess.model.Activity122Model", package.seeall)

slot0 = class("Activity122Model", BaseModel)
slot1 = 1

function slot0.onInit(slot0)
	slot0.cacheData = nil
	slot0.playerCacheData = nil
end

function slot0.reInit(slot0)
	slot0.cacheData = nil
	slot0.playerCacheData = nil
end

function slot0.getCurActivityID(slot0)
	return slot0._curActivityId
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.getCurEpisodeSightMap(slot0)
	return slot0._curEpisodeSightMap
end

function slot0.checkPosIndexInSight(slot0, slot1)
	return slot0._curEpisodeSightMap[slot1]
end

function slot0.getCurEpisodeFireMap(slot0)
	return slot0._curEpisodeFireMap
end

function slot0.checkPosIndexInFire(slot0, slot1)
	return slot0._curEpisodeFireMap[slot1]
end

function slot0.onReceiveGetAct122InfoReply(slot0, slot1)
	slot0._curActivityId = slot1.activityId
	slot0._curEpisodeId = slot1.lastEpisodeId > 0 and slot1.lastEpisodeId or uv0
	slot0._episodeInfoData = {}
	slot2 = slot1.act122Episodes

	for slot6, slot7 in ipairs(slot1.act122Episodes) do
		slot8 = slot7.id
		slot0._episodeInfoData[slot8] = {
			id = slot7.id,
			star = slot7.star,
			totalCount = slot7.totalCount
		}
	end

	if slot1.map and slot1.map.allFinishInteracts then
		Va3ChessGameModel.instance:updateFinishInteracts(slot1.map.finishInteracts)
		Va3ChessGameModel.instance:updateAllFinishInteracts(slot1.map.allFinishInteracts)
	end
end

function slot0.onReceiveAct122StartEpisodeReply(slot0, slot1)
	slot0:increaseCount(slot1.map.id)
	slot0:initSight(slot1.map.act122Sight)
	slot0:initFire(slot1.map.act122Fire)
end

function slot0.initSight(slot0, slot1)
	slot0._curEpisodeSightMap = {}

	if not slot1 then
		return
	end

	for slot7 = 1, #slot2 do
		slot8 = slot2[slot7]
		slot0._curEpisodeSightMap[Va3ChessMapUtils.calPosIndex(slot8.x, slot8.y)] = true
	end
end

function slot0.updateSight(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._curEpisodeSightMap = slot0._curEpisodeSightMap or {}

	for slot7 = 1, #slot2 do
		slot8 = slot2[slot7]
		slot0._curEpisodeSightMap[Va3ChessMapUtils.calPosIndex(slot8.x, slot8.y)] = true
	end
end

function slot0.initFire(slot0, slot1)
	slot0._curEpisodeFireMap = {}

	if not slot1 then
		return
	end

	for slot7 = 1, #slot2 do
		slot8 = slot2[slot7]
		slot0._curEpisodeFireMap[Va3ChessMapUtils.calPosIndex(slot8.x, slot8.y)] = true
	end
end

function slot0.updateFire(slot0, slot1)
	if not slot1 then
		return
	end

	for slot7 = 1, #slot2 do
		slot8 = slot2[slot7]
		slot0._curEpisodeFireMap[Va3ChessMapUtils.calPosIndex(slot8.x, slot8.y)] = true
	end
end

function slot0.getEpisodeData(slot0, slot1)
	return slot0._episodeInfoData and slot0._episodeInfoData[slot1]
end

function slot0.isEpisodeClear(slot0, slot1)
	if slot0:getEpisodeData(slot1) then
		return slot2.star > 0
	end

	return false
end

function slot0.isEpisodeOpen(slot0, slot1)
	if not slot0:getEpisodeData(slot1) then
		return false
	end

	return Activity122Config.instance:getEpisodeCo(slot0:getCurActivityID(), slot2.id).preEpisode == 0 or slot0:isEpisodeClear(slot3.preEpisode)
end

function slot0.getTaskData(slot0, slot1)
	return TaskModel.instance:getTaskById(slot1)
end

function slot0.increaseCount(slot0, slot1)
	if slot0._episodeInfoData and slot0._episodeInfoData[slot1] then
		slot2.totalCount = slot2.totalCount + 1
	end
end

function slot0.getPlayerCacheData(slot0)
	if not slot0.cacheData then
		if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.Version1_3_Roel2ChessKey, "")) then
			slot0.cacheData = cjson.decode(slot2)
			slot0.playerCacheData = slot0.cacheData[tostring(PlayerModel.instance:getMyUserId())]
		end

		if not slot0.cacheData then
			slot0.cacheData = {}
		end

		if not slot0.playerCacheData then
			slot0.playerCacheData = {
				isNextChapterLock = true,
				lockNodeList = {}
			}
			slot0.cacheData[slot1] = slot0.playerCacheData

			slot0:saveCacheData()
		end
	end

	return slot0.playerCacheData
end

function slot0.saveCacheData(slot0)
	if not slot0.cacheData then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.Version1_3_Roel2ChessKey, cjson.encode(slot0.cacheData))
end

slot0.instance = slot0.New()

return slot0
