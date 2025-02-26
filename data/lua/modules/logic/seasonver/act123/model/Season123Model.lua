module("modules.logic.seasonver.act123.model.Season123Model", package.seeall)

slot0 = class("Season123Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._actInfo = {}
end

function slot0.setActInfo(slot0, slot1)
	if not slot0._actInfo[slot1.activityId] then
		slot0._actInfo[slot2] = Season123MO.New()
		slot0._curSeasonId = slot2
	end

	slot3:updateInfo(slot1)
end

function slot0.updateActInfoBattle(slot0, slot1)
	if slot0._actInfo[slot1.activityId] then
		slot3:updateInfoBattle(slot1)
	end
end

function slot0.cleanCurSeasonId(slot0)
	slot0._curSeasonId = nil
end

function slot0.getActInfo(slot0, slot1)
	if not slot1 then
		return nil
	end

	return slot0._actInfo[slot1]
end

function slot0.setBattleContext(slot0, slot1, slot2, slot3, slot4)
	slot0._battleContext = Season123BattleContext.New()

	slot0._battleContext:init(slot1, slot2, slot3, slot4)
end

function slot0.getBattleContext(slot0)
	return slot0._battleContext
end

function slot0.getSeasonHeroMO(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getActInfo(slot1) then
		return nil
	end

	if not slot5.stageMap[slot2] then
		return nil
	end

	if not slot6.episodeMap[slot3] then
		return nil
	end

	if not slot7.heroesMap then
		return nil
	end

	return slot8[slot4]
end

function slot0.getAssistData(slot0, slot1, slot2)
	if not slot0:getActInfo(slot1) then
		return nil
	end

	slot4 = nil

	if not ((slot2 ~= nil or slot3:getCurrentStage()) and slot3:getStageMO(slot2)) then
		return nil
	end

	return slot4:getAssistHeroMO()
end

function slot0.isSeasonStagePosUnlock(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getActInfo(slot1) then
		return
	end

	return slot5:isStageSlotUnlock(slot2, slot0:getUnlockCardIndex(slot4, slot3)) or slot5.unlockIndexSet and slot5.unlockIndexSet[slot6]
end

function slot0.getUnlockCardIndex(slot0, slot1, slot2)
	if slot1 == Season123EquipHeroItemListModel.MainCharPos then
		return ModuleEnum.MaxHeroCountInGroup * 2 + slot2
	else
		return slot1 + 1 + ModuleEnum.MaxHeroCountInGroup * (slot2 - 1)
	end
end

function slot0.isEpisodeAdvance(slot0, slot1)
	return false
end

function slot0.getEpisodeRetail(slot0, slot1)
	return nil
end

function slot0.getCurSeasonId(slot0)
	return slot0._curSeasonId
end

function slot0.getAllItemMo(slot0, slot1)
	if slot0._actInfo[slot1] then
		return slot2:getAllItemMap()
	end
end

function slot0.getSeasonAllHeroGroup(slot0, slot1)
	if slot0._actInfo[slot1] then
		return slot2.heroGroupSnapshot
	end
end

function slot0.updateItemMap(slot0, slot1, slot2, slot3)
	slot4 = slot0:getAllItemMo(slot1)

	if GameUtil.getTabLen(slot2) > 0 then
		for slot8, slot9 in ipairs(slot2) do
			if Season123Config.instance:getSeasonEquipCo(slot9.itemId) and not slot4[slot9.uid] and slot9.uid then
				slot11 = Season123ItemMO.New()

				slot11:setData(slot9)

				slot4[slot9.uid] = slot11
			end
		end
	end

	if GameUtil.getTabLen(slot3) > 0 then
		for slot8, slot9 in ipairs(slot3) do
			if Season123Config.instance:getSeasonEquipCo(slot9.itemId) then
				slot4[slot9.uid] = nil
			end
		end
	end
end

function slot0.getSnapshotHeroGroup(slot0, slot1)
	if slot0._battleContext then
		if not slot0:getActInfo(slot0._battleContext.actId) then
			return
		end

		return slot3.heroGroupSnapshot[slot1 or slot3.heroGroupSnapshotSubId]
	end
end

function slot0.getRetailHeroGroup(slot0, slot1)
	if not slot0:getActInfo(slot0._battleContext.actId) then
		return
	end

	return slot3.retailHeroGroups[slot1 or 1]
end

function slot0.isEpisodeAfterStory(slot0, slot1, slot2, slot3)
	return false
end

function slot0.canPlayStageLevelup(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 ~= 1 then
		return
	end

	if slot2 ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	if slot3 then
		return
	end

	if slot0:isEpisodeAfterStory(slot4 or slot0:getCurSeasonId(), slot6) then
		return
	end

	return Season123Config.instance:getSeasonEpisodeCo(slot4, slot5, slot6 + 1) and slot7.stage
end

function slot0.addCardGetData(slot0, slot1)
	slot3 = ViewName[Season123ViewHelper.getViewName(slot0._curSeasonId, "CelebrityCardGetView")]

	for slot7 = 1, PopupController.instance._popupList:getSize() do
		if PopupController.instance._popupList._dataList[slot7][2] == slot3 then
			slot8 = PopupController.instance._popupList._dataList[slot7][3].data

			tabletool.addValues(slot8, slot1)

			PopupController.instance._popupList._dataList[slot7][3] = {
				is_item_id = true,
				data = slot8
			}

			return
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, slot3, {
		is_item_id = true,
		data = slot1
	})
end

function slot0.setUnlockAct123EquipIds(slot0, slot1)
	slot0:getActInfo(slot1.activityId):setUnlockAct123EquipIds(slot1.unlockAct123EquipIds)
end

function slot0.isNewEquipBookCard(slot0, slot1)
	if not slot0:getActInfo(slot0._curSeasonId) then
		return
	end

	return not slot2.unlockAct123EquipIds[slot1]
end

function slot0.getAllUnlockAct123EquipIds(slot0, slot1)
	if not slot0:getActInfo(slot1) then
		return
	end

	return slot2.unlockAct123EquipIds
end

function slot0.getFightCardDataList(slot0)
	slot1 = FightModel.instance:getFightParam()

	return Season123HeroGroupUtils.fiterFightCardDataList(slot1.activity104Equips, slot1.trialHeroList, slot0:getCurSeasonId())
end

function slot0.hasSeason123TaskData(slot0, slot1)
	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) then
		for slot6, slot7 in pairs(slot2) do
			if slot7.config and slot7.config.seasonId == slot1 and slot7.config.isRewardView == Activity123Enum.TaskRewardViewType then
				return true
			end
		end
	else
		return false
	end
end

function slot0.updateTaskReward(slot0)
	for slot4, slot5 in pairs(slot0._actInfo) do
		slot5:initStageRewardConfig()
	end
end

function slot0.checkHasUnlockStory(slot0, slot1)
	slot4 = {}
	slot5 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString("Season123StoryUnlock" .. "#" .. tostring(slot1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), "")) then
		for slot9, slot10 in ipairs(cjson.decode(slot3)) do
			slot11 = string.split(slot10, "|")
			slot5[tonumber(slot11[1])] = slot11[2] == "true"
		end
	end

	for slot10, slot11 in pairs(Season123Config.instance:getAllStoryCo(slot1) or {}) do
		if Season123ProgressUtils.isStageUnlock(slot1, slot11.condition) and (uv0.instance:getActInfo(slot1).stageMap[slot11.condition] and slot12.isPass) == true and slot5[slot10] ~= slot14 then
			return true
		end
	end

	return false
end

function slot0.getSingleBgFolder(slot0)
	if slot0._curSeasonId then
		return Activity123Enum.SeasonIconFolder[slot0._curSeasonId]
	end
end

function slot0.setRetailRandomSceneId(slot0, slot1)
	slot0.retailSceneId = PlayerPrefsHelper.getNumber(slot0:getRetailRandomSceneKey(), -1)

	if slot0.retailSceneId < 0 or slot1 and slot1.needRandom then
		slot0.retailSceneId = math.random(0, 2)

		PlayerPrefsHelper.setNumber(slot0:getRetailRandomSceneKey(), slot0.retailSceneId)
	end
end

function slot0.getRetailRandomSceneKey(slot0)
	return "Season123RetailRandomSceneId" .. "#" .. tostring(slot0._curSeasonId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

slot0.instance = slot0.New()

return slot0
