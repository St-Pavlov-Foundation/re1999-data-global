module("modules.logic.achievement.model.AchievementMainListModel", package.seeall)

slot0 = class("AchievementMainListModel", MixScrollModel)

function slot0.initDatas(slot0)
	slot0._moCacheMap = {}
	slot0._moGroupMap = {}
	slot0._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	slot0._fitAchievementCfgTab = {}
	slot0._isCurTaskNeedPlayIdleAnim = false
end

function slot0.refreshTabData(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getAchievementMOList(slot1, slot2, slot3) then
		slot6 = slot0:getFitCategoryAchievementCfgs(slot1, slot3, slot4)

		table.sort(slot6, slot0:getSortFunction(slot2))

		slot0._moCacheMap[slot1][slot2][slot3] = slot0:buildAchievementMOList(slot3, slot2, slot6)
	end

	slot0:setList(slot0:filterFolderAchievement(slot5))
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
	return not AchievementModel.instance:achievementHasLocked(slot1.id)
end

function slot0.filterAchievementByLocked(slot0, slot1)
	return not AchievementModel.instance:isAchievementTaskFinished(AchievementConfig.instance:getAchievementMaxLevelTask(slot1.id) and slot2.id)
end

function slot0.buildAchievementMOList(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot3 then
		for slot8, slot9 in ipairs(slot3) do
			slot11 = false
			slot12 = AchievementListMO.New()

			if slot9.groupId and slot10 ~= 0 then
				slot0._moGroupMap[slot1] = slot0._moGroupMap[slot1] or {}
				slot0._moGroupMap[slot1][slot2] = slot0._moGroupMap[slot1][slot2] or {}

				if not slot0._moGroupMap[slot1][slot2][slot10] then
					slot0._moGroupMap[slot1][slot2][slot10] = {}
					slot11 = true
				end

				table.insert(slot0._moGroupMap[slot1][slot2][slot10], slot12)
			end

			slot12:init(slot9.id, slot11)
			table.insert(slot4, slot12)
		end
	end

	return slot4
end

function slot0.filterFolderAchievement(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if slot7.isGroupTop or not slot7:getIsFold() then
				table.insert(slot2, slot7)
			end
		end
	end

	return slot2
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
	slot2 = slot0 and slot0.id
	slot3 = slot1 and slot1.id

	if slot0.groupId ~= 0 and slot1.groupId ~= 0 then
		slot5 = AchievementConfig.instance:getGroup(slot1.groupId)

		if (AchievementConfig.instance:getGroup(slot0.groupId) and slot4.order or 0) ~= (slot5 and slot5.order or 0) then
			return slot6 < slot7
		end

		if slot0.groupId ~= slot1.groupId then
			return slot1.groupId < slot0.groupId
		end
	end

	if AchievementModel.instance:achievementHasLocked(slot2) ~= AchievementModel.instance:achievementHasLocked(slot3) then
		return not slot4
	end

	return slot2 < slot3
end

function slot0.sortAchievementByRareUp(slot0, slot1)
	slot2 = slot0 and slot0.id
	slot3 = slot1 and slot1.id

	if slot0.groupId ~= 0 and slot1.groupId ~= 0 then
		if AchievementModel.instance:getGroupLevel(slot0.groupId) ~= AchievementModel.instance:getGroupLevel(slot1.groupId) then
			if slot4 * slot5 == 0 then
				return slot4 ~= 0
			end

			return slot4 < slot5
		end

		if slot0.groupId ~= slot1.groupId then
			return slot0.groupId < slot1.groupId
		end
	end

	if AchievementModel.instance:getAchievementLevel(slot2) ~= AchievementModel.instance:getAchievementLevel(slot3) then
		if slot4 * slot5 == 0 then
			return slot4 ~= 0
		end

		return slot4 < slot5
	end

	return slot2 < slot3
end

function slot0.getInfoList(slot0, slot1)
	slot3 = {}

	for slot8, slot9 in ipairs(slot0:getList()) do
		table.insert(slot3, SLFramework.UGUI.MixCellInfo.New(slot9:getAchievementType(), slot9:getLineHeight(AchievementMainCommonModel.instance:getCurrentFilterType(), slot9:getIsFold()), slot8))
	end

	return slot3
end

function slot0.getAchievementIndexAndScrollPixel(slot0, slot1, slot2)
	slot3 = false
	slot4 = 0
	slot5 = 0

	if slot0:getList() then
		for slot11, slot12 in ipairs(slot6) do
			if not slot12:isAchievementMatch(slot1, slot2) then
				slot5 = slot5 + slot12:getLineHeight(AchievementMainCommonModel.instance:getCurrentFilterType(), slot12:getIsFold())
			else
				slot4 = slot11
				slot3 = true

				break
			end
		end
	end

	return slot3, slot4, slot5
end

function slot0.getGroupMOList(slot0, slot1)
	slot4 = slot0._moGroupMap[AchievementMainCommonModel.instance:getCurrentFilterType()] and slot0._moGroupMap[slot2][AchievementMainCommonModel.instance:getCurrentSortType()]

	return slot4 and slot4[slot1]
end

function slot0.isCurTaskNeedPlayIdleAnim(slot0)
	return slot0._isCurTaskNeedPlayIdleAnim
end

function slot0.setIsCurTaskNeedPlayIdleAnim(slot0, slot1)
	slot0._isCurTaskNeedPlayIdleAnim = slot1
end

slot0.instance = slot0.New()

return slot0
