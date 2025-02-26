module("modules.logic.achievement.model.AchievementSelectListModel", package.seeall)

slot0 = class("AchievementSelectListModel", ListScrollModel)

function slot0.initDatas(slot0, slot1)
	slot0._curCategory = slot1 or 1
	slot0.isGroup = false

	slot0:decodeShowAchievement()

	slot0.isGroup = slot0:getGroupSelectedCount() > 0
	slot0.infoDict = slot0:packInfos()
	slot0.moTypeCache = {}
	slot0.moTypeGroupCache = {}
	slot0._itemAniHasShownIndex = 0

	slot0:refreshTabData()
end

function slot0.release(slot0)
	slot0.moTypeCache = nil
	slot0.moTypeGroupCache = nil
	slot0.singleSet = nil
	slot0.singleSelectList = nil
	slot0.groupSet = nil
	slot0.selectSingleCategoryMap = nil
	slot0.selectGroupCategoryMap = nil
end

function slot0.packInfos(slot0)
	slot1 = {
		[slot5] = {}
	}

	for slot5, slot6 in ipairs(AchievementEnum.Type) do
		-- Nothing
	end

	for slot6, slot7 in ipairs(AchievementConfig.instance:getAllAchievements()) do
		slot1[slot7.category] = slot1[slot7.category] or {}

		table.insert(slot1[slot7.category], slot7)
	end

	return slot1
end

function slot0.decodeShowAchievement(slot0)
	slot2, slot3 = AchievementUtils.decodeShowStr(PlayerModel.instance:getShowAchievement())
	slot0.singleSet = {}
	slot0.singleSelectList = {}

	for slot7, slot8 in ipairs(slot2) do
		slot9 = AchievementConfig.instance:getTask(slot8)
		slot0.singleSet[slot9.achievementId] = true

		table.insert(slot0.singleSelectList, slot9.achievementId)
		slot0:updateSingleSelectCategoryMap(slot9.achievementId, true)
	end

	slot0.groupSet = {}
	slot0.groupSelectList = {}

	for slot7, slot8 in pairs(slot3) do
		if AchievementConfig.instance:getTask(slot8) and AchievementConfig.instance:getAchievement(slot9.achievementId).groupId ~= 0 and not slot0.groupSet[slot10.groupId] then
			slot0.groupSet[slot10.groupId] = true

			table.insert(slot0.groupSelectList, slot10.groupId)
			slot0:updateGroupSelectCategoryMap(slot10.groupId, true)
		end
	end

	slot0.originSingleSet = tabletool.copy(slot0.singleSet)
	slot0.originGroupSet = tabletool.copy(slot0.groupSet)
	slot0.originSingleSelectList = tabletool.copy(slot0.singleSelectList)
	slot0.originGroupSelectList = tabletool.copy(slot0.groupSelectList)
end

function slot0.resumeToOriginSelect(slot0)
	slot0.groupSet = tabletool.copy(slot0.originGroupSet)
	slot0.singleSet = tabletool.copy(slot0.originSingleSet)
	slot0.singleSelectList = tabletool.copy(slot0.originSingleSelectList)
	slot0.groupSelectList = tabletool.copy(slot0.originGroupSelectList)

	slot0:buildSelectCategoryMap()
end

function slot0.buildSelectCategoryMap(slot0)
	slot0.selectSingleCategoryMap = {}
	slot0.selectGroupCategoryMap = {}

	if slot0.singleSelectList then
		for slot4, slot5 in ipairs(slot0.singleSelectList) do
			slot0:updateSingleSelectCategoryMap(slot5, true)
		end
	end

	if slot0.groupSelectList then
		for slot4, slot5 in ipairs(slot0.groupSelectList) do
			slot0:updateGroupSelectCategoryMap(slot5, true)
		end
	end
end

function slot0.updateSingleSelectCategoryMap(slot0, slot1, slot2)
	if AchievementConfig.instance:getAchievement(slot1) then
		slot4 = slot3.category

		if slot2 then
			slot0.selectSingleCategoryMap = slot0.selectSingleCategoryMap or {}
			slot0.selectSingleCategoryMap[slot4] = slot0.selectSingleCategoryMap[slot4] or {}
			slot0.selectSingleCategoryMap[slot4][slot1] = true
		elseif not slot2 and slot0.selectSingleCategoryMap and slot0.selectSingleCategoryMap[slot4] then
			slot0.selectSingleCategoryMap[slot4][slot1] = nil
		end
	end
end

function slot0.updateGroupSelectCategoryMap(slot0, slot1, slot2)
	if AchievementConfig.instance:getGroup(slot1) then
		slot4 = slot3.category

		if slot2 then
			slot0.selectGroupCategoryMap = slot0.selectGroupCategoryMap or {}
			slot0.selectGroupCategoryMap[slot4] = slot0.selectGroupCategoryMap[slot4] or {}
			slot0.selectGroupCategoryMap[slot4][slot1] = slot2
		elseif not slot2 and slot0.selectGroupCategoryMap and slot0.selectGroupCategoryMap[slot4] then
			slot0.selectGroupCategoryMap[slot4][slot1] = nil
		end
	end
end

function slot0.setTab(slot0, slot1)
	slot0._curCategory = slot1

	slot0:refreshTabData()
end

function slot0.setIsSelectGroup(slot0, slot1)
	slot0.isGroup = slot1

	slot0:refreshTabData()
end

function slot0.refreshTabData(slot0)
	if not slot0.infoDict then
		return
	end

	if not (slot0.isGroup and slot0.moTypeGroupCache or slot0.moTypeCache)[slot0._curCategory] then
		slot1[slot0._curCategory] = (not slot0.isGroup or slot0:buildGroupMOList(slot0._curCategory)) and slot0:buildSingleMOList(slot0._curCategory)
	end

	slot0:setList(slot2)
end

function slot0.buildSingleMOList(slot0, slot1)
	slot3 = {}

	if not slot0.infoDict[slot1] then
		return {}
	end

	table.sort(slot4, slot0.sortAchievement)

	for slot8, slot9 in ipairs(slot4) do
		if AchievementModel.instance:getAchievementLevel(slot9.id) > 0 then
			if AchievementEnum.MainListLineCount <= #slot3 then
				slot0:buildMO(slot2, slot3, 0)

				slot3 = {}
			end

			table.insert(slot3, slot9)
		end
	end

	if #slot3 > 0 then
		slot0:buildMO(slot2, slot3, 0)
	end

	return slot2
end

function slot0.buildGroupMOList(slot0, slot1)
	slot3 = {}

	if not slot0.infoDict[slot1] then
		return {}
	end

	table.sort(slot4, slot0.sortAchievement)

	slot5 = 0

	for slot9, slot10 in ipairs(slot4) do
		if slot10.groupId ~= 0 then
			if slot5 ~= slot10.groupId then
				if slot5 == 0 then
					slot5 = slot10.groupId
				else
					slot0:buildMO(slot2, slot3, slot5)

					slot3 = {}
					slot5 = slot10.groupId
				end
			end

			table.insert(slot3, slot10)
		end
	end

	if #slot3 > 0 then
		slot0:buildMO(slot2, slot3, slot5)
	end

	return slot2
end

function slot0.buildMO(slot0, slot1, slot2, slot3)
	if slot3 ~= 0 then
		slot4 = false

		for slot8, slot9 in ipairs(slot2) do
			if AchievementModel.instance:getAchievementLevel(slot9.id) > 0 then
				slot4 = true

				break
			end
		end

		if not slot4 then
			return
		end
	end

	slot4 = AchievementTileMO.New()

	slot4:init(slot2, slot3)
	table.insert(slot1, slot4)
end

function slot0.sortAchievement(slot0, slot1)
	if uv0.instance:checkIsSelected(slot0) ~= uv0.instance:checkIsSelected(slot1) then
		return slot2
	elseif slot2 and slot3 then
		slot5 = uv0.instance.isGroup and uv0.instance.groupSelectList or uv0.instance.singleSelectList

		return (tabletool.indexOf(slot5, slot4 and slot0.groupId or slot0.id) or 0) < (tabletool.indexOf(slot5, slot4 and slot1.groupId or slot1.id) or 0)
	end

	if slot0.groupId ~= 0 ~= (slot1.groupId ~= 0) then
		return not slot4
	end

	if slot4 then
		if slot0.groupId ~= slot1.groupId then
			slot7 = AchievementConfig.instance:getGroup(slot1.groupId)

			if AchievementConfig.instance:getGroup(slot0.groupId) and slot7 and slot6.order ~= slot7.order then
				return slot6.order < slot7.order
			end

			return slot0.groupId < slot1.groupId
		end

		if slot0.order ~= slot1.order then
			return slot0.order < slot1.order
		end
	end

	return slot0.id < slot1.id
end

function slot0.checkIsSelected(slot0, slot1)
	if slot0.isGroup and slot1.groupId ~= 0 then
		return slot0:isGroupSelected(slot1.groupId)
	else
		if AchievementConfig.instance:getTasksByAchievementId(slot1.id) then
			for slot6, slot7 in pairs(slot2) do
				if slot0:isSingleSelected(slot7.id) then
					return true
				end
			end
		end

		return false
	end
end

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot7, slot8:getLineHeight(), slot7))
	end

	return slot2
end

function slot0.isSingleSelected(slot0, slot1)
	if AchievementConfig.instance:getTask(slot1) then
		return slot0.singleSet[slot2.achievementId]
	end

	return false
end

function slot0.getSelectOrderIndex(slot0, slot1)
	if AchievementConfig.instance:getTask(slot1) then
		return tabletool.indexOf(slot0.singleSelectList, slot2.achievementId)
	end
end

function slot0.isGroupSelected(slot0, slot1)
	return slot0.groupSet[slot1]
end

function slot0.getSingleSelectedCount(slot0)
	return tabletool.len(slot0.singleSet)
end

function slot0.getGroupSelectedCount(slot0)
	return tabletool.len(slot0.groupSet)
end

function slot0.setSingleSelect(slot0, slot1, slot2)
	if not AchievementConfig.instance:getTask(slot1) then
		return
	end

	tabletool.removeValue(slot0.singleSelectList, slot3.achievementId)

	if slot2 then
		slot0.singleSet[slot3.achievementId] = true

		table.insert(slot0.singleSelectList, slot3.achievementId)
	else
		slot0.singleSet[slot3.achievementId] = nil
	end

	slot0:updateSingleSelectCategoryMap(slot3.achievementId, slot2)
end

function slot0.setGroupSelect(slot0, slot1, slot2)
	tabletool.removeValue(slot0.groupSelectList, slot1)

	if slot2 then
		slot0.groupSet[slot1] = true

		table.insert(slot0.groupSelectList, slot1)
	else
		slot0.groupSet[slot1] = nil
	end

	slot0:updateGroupSelectCategoryMap(slot1, slot2)
end

function slot0.getSaveRequestParam(slot0)
	slot1 = {}
	slot2 = 0

	if slot0.isGroup then
		for slot6, slot7 in ipairs(slot0.groupSelectList) do
			slot0:fillGroupTaskIds(slot1, slot7)

			slot2 = slot7
		end
	else
		for slot6, slot7 in ipairs(slot0.singleSelectList) do
			slot0:fillSingleTaskId(slot1, slot7)
		end
	end

	return slot1, slot2
end

function slot0.getCurrentCategory(slot0)
	return slot0._curCategory
end

function slot0.fillGroupTaskIds(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(AchievementConfig.instance:getAchievementsByGroupId(slot2)) do
		slot0:fillSingleTaskId(slot1, slot8.id)
	end
end

function slot0.fillSingleTaskId(slot0, slot1, slot2)
	if AchievementModel.instance:getAchievementLevel(slot2) > 0 and AchievementConfig.instance:getTaskByAchievementLevel(slot2, slot3) ~= nil then
		table.insert(slot1, slot4.id)
	end
end

function slot0.checkDirty(slot0, slot1)
	if slot1 then
		if tabletool.len(slot0.groupSet) == tabletool.len(slot0.originGroupSet) then
			for slot5, slot6 in pairs(slot0.groupSet) do
				if slot6 ~= slot0.originGroupSet[slot5] then
					return true
				end
			end
		else
			return true
		end
	elseif #slot0.singleSelectList == #slot0.originSingleSelectList then
		for slot5, slot6 in ipairs(slot0.singleSelectList) do
			if slot6 ~= slot0.originSingleSelectList[slot5] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function slot0.clearAllSelect(slot0)
	slot0.singleSet = {}
	slot0.singleSelectList = {}
	slot0.groupSet = {}
	slot0.groupSelectList = {}
	slot0.selectSingleCategoryMap = {}
	slot0.selectGroupCategoryMap = {}
end

function slot0.getSelectCount(slot0)
	if slot0.isGroup then
		return slot0.groupSet and tabletool.len(slot0.groupSet) or 0
	else
		return slot0.singleSet and tabletool.len(slot0.singleSet) or 0
	end
end

function slot0.getSelectCountByCategory(slot0, slot1)
	slot2 = slot0.isGroup and slot0.selectGroupCategoryMap or slot0.selectSingleCategoryMap
	slot3 = slot2 and slot2[slot1]

	return slot3 and tabletool.len(slot3) or 0
end

function slot0.getItemAniHasShownIndex(slot0)
	return slot0._itemAniHasShownIndex
end

function slot0.setItemAniHasShownIndex(slot0, slot1)
	slot0._itemAniHasShownIndex = slot1 or 0
end

slot0.instance = slot0.New()

return slot0
