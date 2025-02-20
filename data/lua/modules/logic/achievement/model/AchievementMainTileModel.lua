module("modules.logic.achievement.model.AchievementMainTileModel", package.seeall)

slot0 = class("AchievementMainTileModel", ListScrollModel)

function slot0.initDatas(slot0)
	slot0._moCacheMap = {}
	slot0._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	slot0._groupStateMap = {}
	slot0._fitAchievementCfgTab = {}
	slot0._curScrollFocusIndex = 1
	slot0._hasPlayOpenAnim = false
end

function slot0.refreshTabData(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getAchievementMOList(slot1, slot2, slot3) then
		slot6 = slot0:getFitCategoryAchievementCfgs(slot1, slot3, slot4)

		table.sort(slot6, slot0:getSortFunction(slot2))

		slot0._moCacheMap[slot1][slot2][slot3] = slot0:buildAchievementMOList(slot6)
	end

	slot0:setList(slot5)
end

function slot0.getAchievementMOList(slot0, slot1, slot2, slot3)
	slot0._moCacheMap[slot1] = slot0._moCacheMap[slot1] or {}
	slot0._moCacheMap[slot1][slot2] = slot0._moCacheMap[slot1][slot2] or {}

	return slot0._moCacheMap[slot1][slot2][slot3]
end

function slot0.getFitCategoryAchievementCfgs(slot0, slot1, slot2, slot3)
	slot0._fitAchievementCfgTab = slot0._fitAchievementCfgTab or {}

	if slot3 and not (slot0._fitAchievementCfgTab and slot0._fitAchievementCfgTab[slot1]) then
		slot4 = {}

		for slot8, slot9 in ipairs(slot3) do
			for slot13, slot14 in pairs(AchievementEnum.SearchFilterType) do
				slot4[slot14] = slot4[slot14] or {}

				if slot0:getSearchFilterFunction(slot14) and slot15(slot0, slot9) then
					table.insert(slot4[slot14], slot9)
				end
			end
		end

		slot0._fitAchievementCfgTab[slot1] = slot4
	end

	return slot0._fitAchievementCfgTab[slot1][slot2]
end

function slot0.getSearchFilterFunction(slot0, slot1)
	if not slot0._searchFilterFuncMap then
		slot0._searchFilterFuncMap = {
			[AchievementEnum.SearchFilterType.Unlocked] = slot0.filterAchievementByUnlocked,
			[AchievementEnum.SearchFilterType.Locked] = slot0.filterAchievementByLocked,
			[AchievementEnum.SearchFilterType.All] = slot0.filterAchievementByAll
		}
	end

	return slot0._searchFilterFuncMap[slot1]
end

function slot0.filterAchievementByAll(slot0, slot1)
	return true
end

function slot0.filterAchievementByUnlocked(slot0, slot1)
	slot4 = false

	if slot1.groupId and slot2 ~= 0 then
		if slot0._groupStateMap[slot2] == nil then
			slot0._groupStateMap[slot2] = AchievementModel.instance:achievementGroupHasLocked(slot2)
		end

		slot4 = not slot0._groupStateMap[slot2]
	else
		slot4 = not AchievementModel.instance:achievementHasLocked(slot1.id)
	end

	return slot4
end

function slot0.filterAchievementByLocked(slot0, slot1)
	slot4 = false

	if slot1.groupId and slot2 ~= 0 then
		if slot0._groupStateMap[slot2] == nil then
			slot0._groupStateMap[slot2] = AchievementModel.instance:achievementGroupHasLocked(slot2)
		end

		slot4 = slot0._groupStateMap[slot2]
	else
		slot4 = AchievementModel.instance:achievementHasLocked(slot1.id)
	end

	return slot4
end

function slot0.buildAchievementMOList(slot0, slot1)
	slot2 = {}
	slot3 = {}

	if not slot1 then
		return
	end

	slot4 = 0

	for slot8, slot9 in ipairs(slot1) do
		if slot4 == 0 then
			if slot9.groupId ~= 0 or AchievementEnum.MainListLineCount <= #slot3 then
				if #slot3 > 0 then
					slot0:buildMO(slot2, slot3, slot4)

					slot3 = {}
				end

				slot4 = slot9.groupId
			end
		elseif slot9.groupId ~= slot4 then
			slot0:buildMO(slot2, slot3, slot4)

			slot4 = slot9.groupId
			slot3 = {}
		end

		table.insert(slot3, slot9)
	end

	if #slot3 > 0 then
		slot0:buildMO(slot2, slot3, slot4)
	end

	return slot2
end

function slot0.buildMO(slot0, slot1, slot2, slot3)
	slot4 = AchievementTileMO.New()

	slot4:init(slot2, slot3)
	table.insert(slot1, slot4)
end

function slot0.getSortFunction(slot0, slot1)
	if not slot0._sortFuncMap then
		slot0._sortFuncMap = {
			[AchievementEnum.SortType.RareDown] = slot0.sortAchievementByRareDown,
			[AchievementEnum.SortType.RareUp] = slot0.sortAchievementByRareUp
		}
	end

	return slot0._sortFuncMap[slot1]
end

function slot0.sortAchievementByRareDown(slot0, slot1)
	if slot0.groupId ~= 0 ~= (slot1.groupId ~= 0) then
		return not slot2
	end

	if slot2 then
		if slot0.groupId ~= slot1.groupId then
			slot5 = AchievementConfig.instance:getGroup(slot1.groupId)

			if (AchievementConfig.instance:getGroup(slot0.groupId) and slot4.order or 0) ~= (slot5 and slot5.order or 0) then
				return slot6 < slot7
			end

			return slot0.groupId < slot1.groupId
		end

		return slot0.order < slot1.order
	else
		if AchievementModel.instance:achievementHasLocked(slot0.id) ~= AchievementModel.instance:achievementHasLocked(slot1.id) then
			return not slot6
		end

		return slot4 < slot5
	end
end

function slot0.sortAchievementByRareUp(slot0, slot1)
	if slot0.groupId ~= 0 ~= (slot1.groupId ~= 0) then
		return not slot2
	end

	if slot2 then
		if slot0.groupId ~= slot1.groupId then
			if AchievementModel.instance:getGroupLevel(slot0.groupId) ~= AchievementModel.instance:getGroupLevel(slot1.groupId) then
				if slot4 * slot5 == 0 then
					return slot4 ~= 0
				end

				return slot4 < slot5
			end

			return slot0.groupId < slot1.groupId
		end

		return slot0.order < slot1.order
	else
		if AchievementModel.instance:getAchievementLevel(slot0.id) ~= AchievementModel.instance:getAchievementLevel(slot1.id) then
			if slot6 * slot6 == 0 then
				return slot6 ~= 0
			end

			return slot6 < slot7
		end

		return slot4 < slot5
	end
end

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot8:getAchievementType(), slot8:getLineHeight(), slot7))
	end

	return slot2
end

function slot0.getAchievementIndexAndScrollPixel(slot0, slot1, slot2)
	slot3 = false
	slot4 = 0
	slot5 = 0

	if slot0:getList() then
		for slot10, slot11 in ipairs(slot6) do
			if not slot11:isAchievementMatch(slot1, slot2) then
				slot5 = slot5 + slot11:getLineHeight()
			else
				slot4 = slot10
				slot3 = true

				break
			end
		end
	end

	return slot3, slot4, slot5
end

function slot0.getCurrentAchievementIds(slot0)
	slot1 = {}
	slot4 = slot0:getFitCategoryAchievementCfgs(AchievementMainCommonModel.instance:getCurrentCategory(), AchievementMainCommonModel.instance:getCurrentFilterType())
	slot10 = slot0:getSortFunction(AchievementMainCommonModel.instance:getCurrentSortType())

	table.sort(slot4, slot10)

	for slot10, slot11 in ipairs(slot4) do
		table.insert(slot1, slot11.id)
	end

	return slot1
end

function slot0.markTaskHasShowNewEffect(slot0, slot1)
	if slot1 then
		slot0._newEffectTaskDict = slot0._newEffectTaskDict or {}
		slot0._newEffectTaskDict[slot1] = true
	end
end

function slot0.isTaskHasShowNewEffect(slot0, slot1)
	return slot0._newEffectTaskDict and slot0._newEffectTaskDict[slot1]
end

function slot0.hasPlayOpenAnim(slot0)
	return slot0._hasPlayOpenAnim
end

function slot0.setHasPlayOpenAnim(slot0, slot1)
	slot0._hasPlayOpenAnim = slot1
end

function slot0.markScrollFocusIndex(slot0, slot1)
	slot0._curScrollFocusIndex = slot1
end

function slot0.getScrollFocusIndex(slot0)
	return slot0._curScrollFocusIndex
end

function slot0.resetScrollFocusIndex(slot0)
	slot0._curScrollFocusIndex = nil
end

slot0.instance = slot0.New()

return slot0
