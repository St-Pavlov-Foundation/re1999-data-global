module("modules.logic.dungeon.model.DungeonMapModel", package.seeall)

slot0 = class("DungeonMapModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._mapIds = {}
	slot0._elements = {}
	slot0._rewardPointInfoList = {}
	slot0._curMap = nil
	slot0._dialogHistory = {}
	slot0._dialogIdHistory = {}
	slot0._equipSpChapters = {}
	slot0.lastElementBattleId = nil
	slot0.playAfterStory = nil
	slot0._finishElements = {}
	slot0.focusEpisodeTweenDuration = nil
	slot0.directFocusElement = nil
	slot0.preloadMapCfg = nil
	slot0._puzzleStatusMap = nil
	slot0._mapInteractiveItemVisible = nil
end

function slot0.addDialog(slot0, slot1, slot2, slot3, slot4)
	table.insert(slot0._dialogHistory, {
		slot1,
		slot2,
		slot3,
		slot4
	})
end

function slot0.getDialog(slot0)
	return slot0._dialogHistory
end

function slot0.clearDialog(slot0)
	slot0._dialogHistory = {}
end

function slot0.addDialogId(slot0, slot1)
	table.insert(slot0._dialogIdHistory, slot1)
end

function slot0.getDialogId(slot0)
	return slot0._dialogIdHistory
end

function slot0.clearDialogId(slot0)
	slot0._dialogIdHistory = {}
end

function slot0.updateMapIds(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._mapIds[slot6] = slot6
	end
end

function slot0.mapIsUnlock(slot0, slot1)
	return slot0._mapIds[slot1]
end

function slot0.getElementById(slot0, slot1)
	return slot0._elements[slot1]
end

function slot0.addFinishedElement(slot0, slot1)
	slot0._finishElements[slot1] = true
end

function slot0.addFinishedElements(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._finishElements[slot6] = true
	end
end

function slot0.elementIsFinished(slot0, slot1)
	return slot0._finishElements[slot1]
end

function slot0.getNewElements(slot0)
	return slot0._newElements
end

function slot0.clearNewElements(slot0)
	slot0._newElements = nil
end

function slot0.setNewElements(slot0, slot1)
	slot0._newElements = slot1
end

function slot0.addElements(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._elements[slot6] = slot6
	end
end

function slot0.removeElement(slot0, slot1)
	slot0._elements[slot1] = nil
end

function slot0.getAllElements(slot0)
	return slot0._elements
end

function slot0.getElements(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._elements) do
		if VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot7) and DungeonConfig.instance:isActivity1_2Map(slot1) then
			table.insert(slot2, DungeonConfig.instance:getChapterMapElement(slot7))
		elseif slot8 and slot8.mapId == slot1 then
			slot9 = true

			if ToughBattleConfig.instance:isActEleCo(slot8) and not ToughBattleModel.instance:getActIsOnline() then
				slot9 = false
			end

			if slot9 then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.initEquipSpChapters(slot0, slot1)
	slot0._equipSpChapters = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0._equipSpChapters, slot6)
	end
end

function slot0.updateEquipSpChapter(slot0, slot1, slot2)
	if slot2 == false then
		table.insert(slot0._equipSpChapters, slot1)

		return
	end

	tabletool.removeValue(slot0._equipSpChapters, slot1)
	DungeonModel.instance:resetEpisodeInfoByChapterId(slot1)
end

function slot0.getEquipSpChapters(slot0)
	return slot0._equipSpChapters
end

function slot0.isUnlockSpChapter(slot0, slot1)
	return tabletool.indexOf(slot0._equipSpChapters, slot1)
end

function slot0.updateRewardPoint(slot0, slot1, slot2)
	if slot0:getRewardPointInfo(slot1) then
		slot3:setRewardPoint(slot2)
	end
end

function slot0.initRewardPointInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = RewardPointInfoMO.New()

		slot7:init(slot6)

		slot0._rewardPointInfoList[slot7.chapterId] = slot7
	end
end

function slot0.getTotalRewardPointProgress(slot0, slot1)
	slot2, slot3 = slot0:_getRewardPointProgress(slot1)

	return slot2, slot3
end

function slot0._getRewardPointProgress(slot0, slot1)
	if not slot1 or slot1 <= 0 then
		return 0, 0
	end

	slot2 = uv0.instance:getRewardPointValue(slot1)

	if not DungeonConfig.instance:getChapterPointReward(slot1) then
		return slot0:_getRewardPointProgress(DungeonConfig.instance:getChapterCO(slot1).preChapter)
	end

	slot5 = slot3[#slot3].rewardPointNum

	return math.min(slot2, slot5), slot5
end

function slot0.getRewardPointInfo(slot0, slot1)
	return slot0._rewardPointInfoList[0]
end

function slot0.getRewardPointValue(slot0, slot1)
	return slot0:getRewardPointInfo(slot1) and slot2.rewardPoint or 0
end

function slot0.addRewardPoint(slot0, slot1)
	if lua_chapter_map_element.configDict[slot1].rewardPoint <= 0 then
		return
	end

	slot4 = slot0:getRewardPointInfo(lua_chapter_map.configDict[slot2.mapId].chapterId)
	slot4.rewardPoint = slot4.rewardPoint + slot2.rewardPoint
end

function slot0.addPointRewardIds(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0:getRewardPointInfo(lua_chapter_point_reward.configDict[slot6].chapterId).hasGetPointRewardIds, slot6)
	end
end

function slot0.getUnfinishedTargetReward(slot0)
	slot1 = uv0.instance:getRewardPointInfo()
	slot2 = nil

	for slot6, slot7 in ipairs(lua_chapter_point_reward.configList) do
		if slot7.display > 0 and (slot1.rewardPoint < slot7.rewardPointNum or not tabletool.indexOf(slot1.hasGetPointRewardIds, slot2.id)) then
			break
		end
	end

	return slot2
end

function slot0.canGetAllRewardsList(slot0)
	return uv0.instance:canGetRewardsList(lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId)
end

function slot0.canGetRewardsList(slot0, slot1)
	slot2 = {}

	for slot6 = 101, slot1 do
		tabletool.addValues(slot2, uv0.instance:canGetRewards(slot6))
	end

	return slot2
end

function slot0.canGetRewards(slot0, slot1)
	if not slot0:getRewardPointInfo(slot1) then
		return nil
	end

	if slot2.rewardPoint <= 0 then
		return nil
	end

	if not DungeonConfig.instance:getChapterPointReward(slot1) then
		return {}
	end

	for slot9, slot10 in ipairs(slot5) do
		if slot10.rewardPointNum > 0 and slot10.rewardPointNum <= slot3 and not tabletool.indexOf(slot2.hasGetPointRewardIds, slot10.id) then
			table.insert(slot4, slot10.id)
		end
	end

	return slot4
end

function slot0.isUnFinishedElement(slot0, slot1)
	slot2 = DungeonConfig.instance:getChapterEpisodeCOList(slot1)

	if slot0:_getMapElementsNum(DungeonConfig.instance:getChapterMapCfg(slot1, 0)) > 0 then
		return true
	end

	for slot7, slot8 in ipairs(slot2) do
		if slot0:_getMapElementsNum(DungeonConfig.instance:getChapterMapCfg(slot8.chapterId, slot8.id)) > 0 then
			return true
		end
	end

	return false
end

function slot0._getMapElementsNum(slot0, slot1)
	if slot1 and uv0.instance:mapIsUnlock(slot1.id) then
		for slot7, slot8 in ipairs(uv0.instance:getElements(slot1.id)) do
			if not string.nilorempty(slot8.effect) then
				slot3 = 0 + 1
			end
		end

		return slot3
	end

	return 0
end

function slot0.getChapterLastMap(slot0, slot1, slot2)
	slot4, slot5 = nil

	for slot9, slot10 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot1)) do
		if DungeonModel.instance:getEpisodeInfo(slot10.id) and slot11.isNew and DungeonConfig.instance:getChapterMapCfg(slot1, slot10.id) then
			slot4 = slot12

			break
		end

		if not (slot10.id == slot2) and DungeonModel.instance:hasPassLevelAndStory(slot10.id) and DungeonConfig.instance:getChapterMapCfg(slot1, slot10.id) then
			slot4 = slot12
		end
	end

	return slot4 or DungeonConfig.instance:getChapterMapCfg(slot1, 0)
end

function slot0.initMapPuzzleStatus(slot0, slot1)
	slot0._puzzleStatusMap = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0._puzzleStatusMap[slot6] = true
		end
	end
end

function slot0.hasMapPuzzleStatus(slot0, slot1)
	return slot0._puzzleStatusMap ~= nil and slot0._puzzleStatusMap[slot1]
end

function slot0.setPuzzleStatus(slot0, slot1)
	slot0._puzzleStatusMap = slot0._puzzleStatusMap or {}
	slot0._puzzleStatusMap[slot1] = true
end

function slot0.setMapInteractiveItemVisible(slot0, slot1)
	slot0._mapInteractiveItemVisible = slot1
end

function slot0.getMapInteractiveItemVisible(slot0)
	return slot0._mapInteractiveItemVisible
end

slot0.instance = slot0.New()

return slot0
