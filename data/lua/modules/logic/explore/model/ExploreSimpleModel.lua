module("modules.logic.explore.model.ExploreSimpleModel", package.seeall)

slot0 = class("ExploreSimpleModel", BaseModel)

function slot0.onInit(slot0)
	slot0.nowMapId = 0
	slot0.chapterInfos = {}
	slot0.mapInfos = {}
	slot0.unLockMaps = {}
	slot0.unLockChapters = {}
	slot0.localData = nil
	slot0.taskRed = nil
	slot0.isShowBag = false
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.onGetInfo(slot0, slot1)
	slot0.nowMapId = slot1.lastMapId
	slot0.isShowBag = slot1.isShowBag

	for slot5, slot6 in ipairs(slot1.chapterSimple) do
		slot7 = ExploreChapterSimpleMo.New()

		slot7:init(slot6)

		slot0.chapterInfos[slot6.chapterId] = slot7
	end

	for slot5, slot6 in ipairs(slot1.unlockMapIds) do
		slot0.unLockMaps[slot6] = true

		if ExploreConfig.instance:getMapIdConfig(slot6) then
			slot0.unLockChapters[slot7.chapterId] = true
		end
	end

	for slot5, slot6 in ipairs(slot1.mapSimple) do
		slot7 = ExploreMapSimpleMo.New()

		slot7:init(slot6)

		slot0.mapInfos[slot6.mapId] = slot7
	end
end

function slot0.setShowBag(slot0)
	if not slot0.isShowBag then
		slot0.isShowBag = true

		if isDebugBuild then
			ExploreController.instance:dispatchEvent(ExploreEvent.ShowBagBtn)
		end
	end
end

function slot0.getChapterIndex(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return 1, 1
	end

	for slot7 = #DungeonConfig.instance:getExploreChapterList(), 1, -1 do
		for slot12 = #DungeonConfig.instance:getChapterEpisodeCOList(slot3[slot7].id), 1, -1 do
			if not slot1 or not slot2 then
				if slot0:getMapIsUnLock(lua_explore_scene.configDict[slot3[slot7].id][slot8[slot12].id].id) then
					return slot7, slot12, slot3[slot7].id, slot8[slot12].id
				end
			elseif slot3[slot7].id == slot1 and slot8[slot12].id == slot2 then
				return slot7, slot12, slot1, slot2
			end
		end
	end

	return 1, 1
end

function slot0.getMapIsUnLock(slot0, slot1)
	return slot0.unLockMaps[slot1] or false
end

function slot0.setNowMapId(slot0, slot1)
	slot0.nowMapId = slot1
end

function slot0.onGetArchive(slot0, slot1)
	if not slot0:getMapConfig() then
		logError("没有地图数据？？")

		return
	end

	if not slot0.chapterInfos[slot2.chapterId] then
		return
	end

	slot0:markArchive(slot2.chapterId, true, slot1)
	slot0.chapterInfos[slot2.chapterId]:onGetArchive(slot1)
end

function slot0.getChapterMo(slot0, slot1)
	return slot0.chapterInfos[slot1]
end

function slot0.isChapterFinish(slot0, slot1)
	return slot0:getChapterMo(slot1) and slot2.isFinish or false
end

function slot0.onGetBonus(slot0, slot1, slot2)
	if not slot0:getMapConfig() then
		logError("没有地图数据？？")

		return
	end

	if not slot0.chapterInfos[slot3.chapterId] then
		return
	end

	slot0.chapterInfos[slot3.chapterId]:onGetBonus(slot1, slot2)
end

function slot0.onGetCoin(slot0, slot1, slot2)
	if not slot0.mapInfos[ExploreModel.instance:getMapId()] then
		slot0.mapInfos[slot3] = ExploreMapSimpleMo.New()
	end

	slot0.mapInfos[slot3]:onGetCoin(slot1, slot2)
end

function slot0.getMapConfig(slot0)
	return ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId())
end

function slot0.getBonusIsGet(slot0, slot1, slot2)
	if not slot0.mapInfos[slot1] then
		return false
	end

	return slot0.mapInfos[slot1].bonusIds[slot2] or false
end

function slot0.setBonusIsGet(slot0, slot1, slot2)
	if not slot0.mapInfos[slot1] then
		slot0.mapInfos[slot1] = ExploreMapSimpleMo.New()
	end

	slot0.mapInfos[slot1].bonusIds[slot2] = true
end

function slot0.getCoinCountByMapId(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = 0
	slot6 = 0
	slot7 = 0

	if slot0.mapInfos[slot1] then
		slot2 = slot8.bonusNum
		slot3 = slot8.goldCoin
		slot4 = slot8.purpleCoin
		slot5 = slot8.bonusNumTotal
		slot6 = slot8.goldCoinTotal
		slot7 = slot8.purpleCoinTotal
	end

	return slot2, slot3, slot4, slot5, slot6, slot7
end

function slot0.getChapterCoinCount(slot0, slot1)
	for slot12, slot13 in pairs(ExploreConfig.instance:getMapIdsByChapter(slot1)) do
		if slot0.mapInfos[slot13] then
			slot3 = 0 + slot14.bonusNum
			slot4 = 0 + slot14.goldCoin
			slot5 = 0 + slot14.purpleCoin
			slot6 = 0 + slot14.bonusNumTotal
			slot7 = 0 + slot14.goldCoinTotal
			slot8 = 0 + slot14.purpleCoinTotal
		end
	end

	return slot3, slot4, slot5, slot6, slot7, slot8
end

function slot0.isChapterCoinFull(slot0, slot1)
	slot2, slot3, slot4, slot5, slot6, slot7 = slot0:getChapterCoinCount(slot1)

	return slot2 == slot5 and slot3 == slot6 and slot4 == slot7
end

function slot0.getMapCoinCount(slot0, slot1)
	if not slot0.mapInfos[slot1 or ExploreModel.instance:getMapId()] then
		return 0, 0, 0, 0, 0, 0
	end

	return slot2.bonusNum, slot2.goldCoin, slot2.purpleCoin, slot2.bonusNumTotal, slot2.goldCoinTotal, slot2.purpleCoinTotal
end

function slot0.getChapterIsUnLock(slot0, slot1)
	return slot0.unLockChapters[slot1] or false
end

function slot0.checkTaskRed(slot0)
	slot0.taskRed = {}

	if not TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Explore) then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		if lua_task_explore.configDict[slot6.id] and slot7.maxProgress <= slot6.progress and slot6.finishCount <= 0 then
			slot8 = string.splitToNumber(slot7.listenerParam, "#")
			slot0.taskRed[slot8[1]] = slot0.taskRed[slot8[1]] or {}
			slot0.taskRed[slot8[1]][slot8[2]] = true
		end
	end
end

function slot0.getTaskRed(slot0, slot1, slot2)
	return slot0.taskRed and slot0.taskRed[slot1] and slot0.taskRed[slot1][slot2] or false
end

function slot0.markChapterNew(slot0, slot1)
	slot0:_getLocalData()

	if slot0:getChapterIsNew(slot1) then
		if slot0.localData[tostring(slot1)] then
			slot0.localData[slot2].isMark = true
		else
			slot0.localData[slot2] = {
				isMark = true
			}
		end

		slot0:savePrefData()
	end
end

function slot0.markChapterShowUnlock(slot0, slot1)
	slot0:_getLocalData()

	if not slot0:getChapterIsShowUnlock(slot1) then
		if slot0.localData[tostring(slot1)] then
			slot0.localData[slot2].isShowUnlock = true
		else
			slot0.localData[slot2] = {
				isShowUnlock = true
			}
		end

		slot0:savePrefData()
	end
end

function slot0.markEpisodeShowUnlock(slot0, slot1, slot2)
	slot0:_getLocalData()

	if not slot0:getEpisodeIsShowUnlock(slot1, slot2) then
		if not slot0.localData[tostring(slot1)] then
			slot0.localData[slot3] = {}
		end

		if not slot4.unLockEpisodes then
			slot4.unLockEpisodes = {}
		end

		table.insert(slot4.unLockEpisodes, slot2)
		slot0:savePrefData()
	end
end

function slot0.markArchive(slot0, slot1, slot2, slot3)
	slot0:_getLocalData()

	if slot2 or not slot2 and slot0:getHaveNewArchive(slot1) ~= slot2 then
		slot4 = tostring(slot1)

		if slot2 then
			slot0.localData[slot4] = slot0.localData[slot4] or {}
			slot0.localData[slot4].archive = slot0.localData[slot4].archive or {}

			table.insert(slot0.localData[slot4].archive, slot3)
		elseif slot0.localData[slot4] then
			slot0.localData[slot4].archive = nil
		end

		slot0:savePrefData()
	end
end

function slot0.getChapterIsNew(slot0, slot1)
	if not slot0:getChapterIsUnLock(slot1) then
		return false
	end

	slot0:_getLocalData()

	return not slot0.localData[tostring(slot1)] or not slot0.localData[slot2].isMark
end

function slot0.getChapterIsShowUnlock(slot0, slot1)
	if not slot0:getChapterIsUnLock(slot1) then
		return false
	end

	slot0:_getLocalData()

	return slot0.localData[tostring(slot1)] and slot0.localData[slot2].isShowUnlock
end

function slot0.getEpisodeIsShowUnlock(slot0, slot1, slot2)
	if not slot0:getChapterIsUnLock(slot1) then
		return false
	end

	slot0:_getLocalData()

	if not slot0.localData[tostring(slot1)] or not slot4.unLockEpisodes then
		return false
	end

	return tabletool.indexOf(slot4.unLockEpisodes, slot2) and true or false
end

function slot0.getCollectFullIsShow(slot0, slot1, slot2, slot3)
	if not slot0:getChapterIsUnLock(slot1) then
		return false
	end

	slot0:_getLocalData()

	if slot0.localData[tostring(slot1)] and slot3 then
		slot5 = slot5[tostring(slot3)]
	end

	if not slot5 then
		return false
	end

	return slot5[string.format("collect%d", slot2)] or false
end

function slot0.markCollectFullIsShow(slot0, slot1, slot2, slot3)
	if not slot0:getChapterIsUnLock(slot1) then
		return false
	end

	if not slot0:getCollectFullIsShow(slot1, slot2, slot3) then
		if not slot0.localData[tostring(slot1)] then
			slot5 = {}
			slot0.localData[slot4] = {}
		end

		slot2 = string.format("collect%d", slot2)

		if slot3 and not slot0.localData[slot4][tostring(slot3)] then
			slot0.localData[slot4][slot3] = {}
		end

		slot5[slot2] = true

		slot0:savePrefData()
	end
end

function slot0.getLastSelectMap(slot0)
	slot0:_getLocalData()

	return slot0.localData.lastChapterId, slot0.localData.lastEpisodeId
end

function slot0.setLastSelectMap(slot0, slot1, slot2)
	slot0:_getLocalData()

	slot0.localData.lastEpisodeId = slot2
	slot0.localData.lastChapterId = slot1

	slot0:savePrefData()
end

function slot0.getHaveNewArchive(slot0, slot1)
	slot0:_getLocalData()

	return slot0.localData[tostring(slot1)] and slot0.localData[slot2].archive or false
end

function slot0.getNewArchives(slot0, slot1)
	slot0:_getLocalData()

	return slot0.localData[tostring(slot1)] and slot0.localData[slot2].archive or {}
end

function slot0._getLocalData(slot0)
	if not slot0.localData then
		if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId(), "")) then
			slot0.localData = {}
		else
			slot0.localData = cjson.decode(slot1)
		end
	end

	return slot0.localData
end

function slot0.setDelaySave(slot0, slot1)
	slot0._delaySave = slot1

	if not slot0._delaySave then
		slot0:savePrefData()
	end
end

function slot0.savePrefData(slot0)
	if slot0._delaySave then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId(), cjson.encode(slot0.localData))
end

slot0.instance = slot0.New()

return slot0
