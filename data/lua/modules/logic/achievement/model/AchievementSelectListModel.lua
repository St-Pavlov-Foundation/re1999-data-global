﻿module("modules.logic.achievement.model.AchievementSelectListModel", package.seeall)

local var_0_0 = class("AchievementSelectListModel", ListScrollModel)

function var_0_0.initDatas(arg_1_0, arg_1_1)
	arg_1_0._curCategory = arg_1_1 or 1
	arg_1_0.isGroup = false

	arg_1_0:decodeShowAchievement()

	arg_1_0.isGroup = arg_1_0:getGroupSelectedCount() > 0
	arg_1_0.infoDict = arg_1_0:packInfos()
	arg_1_0.moTypeCache = {}
	arg_1_0.moTypeGroupCache = {}
	arg_1_0._itemAniHasShownIndex = 0

	arg_1_0:refreshTabData()
end

function var_0_0.release(arg_2_0)
	arg_2_0.moTypeCache = nil
	arg_2_0.moTypeGroupCache = nil
	arg_2_0.singleSet = nil
	arg_2_0.singleSelectList = nil
	arg_2_0.groupSet = nil
	arg_2_0.selectSingleCategoryMap = nil
	arg_2_0.selectGroupCategoryMap = nil
end

function var_0_0.packInfos(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(AchievementEnum.Type) do
		var_3_0[iter_3_0] = {}
	end

	local var_3_1 = AchievementConfig.instance:getAllAchievements()

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		var_3_0[iter_3_3.category] = var_3_0[iter_3_3.category] or {}

		local var_3_2 = var_3_0[iter_3_3.category]

		table.insert(var_3_2, iter_3_3)
	end

	return var_3_0
end

function var_0_0.decodeShowAchievement(arg_4_0)
	local var_4_0 = PlayerModel.instance:getShowAchievement()
	local var_4_1, var_4_2 = AchievementUtils.decodeShowStr(var_4_0)

	arg_4_0.singleSet = {}
	arg_4_0.singleSelectList = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_3 = AchievementConfig.instance:getTask(iter_4_1)

		arg_4_0.singleSet[var_4_3.achievementId] = true

		table.insert(arg_4_0.singleSelectList, var_4_3.achievementId)
		arg_4_0:updateSingleSelectCategoryMap(var_4_3.achievementId, true)
	end

	arg_4_0.groupSet = {}
	arg_4_0.groupSelectList = {}

	for iter_4_2, iter_4_3 in pairs(var_4_2) do
		local var_4_4 = AchievementConfig.instance:getTask(iter_4_3)

		if var_4_4 then
			local var_4_5 = AchievementConfig.instance:getAchievement(var_4_4.achievementId)

			if AchievementUtils.isActivityGroup(var_4_4.achievementId) and not arg_4_0.groupSet[var_4_5.groupId] then
				arg_4_0.groupSet[var_4_5.groupId] = true

				table.insert(arg_4_0.groupSelectList, var_4_5.groupId)
				arg_4_0:updateGroupSelectCategoryMap(var_4_5.groupId, true)
			end
		end
	end

	arg_4_0.originSingleSet = tabletool.copy(arg_4_0.singleSet)
	arg_4_0.originGroupSet = tabletool.copy(arg_4_0.groupSet)
	arg_4_0.originSingleSelectList = tabletool.copy(arg_4_0.singleSelectList)
	arg_4_0.originGroupSelectList = tabletool.copy(arg_4_0.groupSelectList)
end

function var_0_0.resumeToOriginSelect(arg_5_0)
	arg_5_0.groupSet = tabletool.copy(arg_5_0.originGroupSet)
	arg_5_0.singleSet = tabletool.copy(arg_5_0.originSingleSet)
	arg_5_0.singleSelectList = tabletool.copy(arg_5_0.originSingleSelectList)
	arg_5_0.groupSelectList = tabletool.copy(arg_5_0.originGroupSelectList)

	arg_5_0:buildSelectCategoryMap()
end

function var_0_0.buildSelectCategoryMap(arg_6_0)
	arg_6_0.selectSingleCategoryMap = {}
	arg_6_0.selectGroupCategoryMap = {}

	if arg_6_0.singleSelectList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.singleSelectList) do
			arg_6_0:updateSingleSelectCategoryMap(iter_6_1, true)
		end
	end

	if arg_6_0.groupSelectList then
		for iter_6_2, iter_6_3 in ipairs(arg_6_0.groupSelectList) do
			arg_6_0:updateGroupSelectCategoryMap(iter_6_3, true)
		end
	end
end

function var_0_0.updateSingleSelectCategoryMap(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = AchievementConfig.instance:getAchievement(arg_7_1)

	if var_7_0 then
		local var_7_1 = var_7_0.category

		if arg_7_2 then
			arg_7_0.selectSingleCategoryMap = arg_7_0.selectSingleCategoryMap or {}
			arg_7_0.selectSingleCategoryMap[var_7_1] = arg_7_0.selectSingleCategoryMap[var_7_1] or {}
			arg_7_0.selectSingleCategoryMap[var_7_1][arg_7_1] = true
		elseif not arg_7_2 and arg_7_0.selectSingleCategoryMap and arg_7_0.selectSingleCategoryMap[var_7_1] then
			arg_7_0.selectSingleCategoryMap[var_7_1][arg_7_1] = nil
		end
	end
end

function var_0_0.updateGroupSelectCategoryMap(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = AchievementConfig.instance:getGroup(arg_8_1)

	if var_8_0 then
		local var_8_1 = var_8_0.category

		if arg_8_2 then
			arg_8_0.selectGroupCategoryMap = arg_8_0.selectGroupCategoryMap or {}
			arg_8_0.selectGroupCategoryMap[var_8_1] = arg_8_0.selectGroupCategoryMap[var_8_1] or {}
			arg_8_0.selectGroupCategoryMap[var_8_1][arg_8_1] = arg_8_2
		elseif not arg_8_2 and arg_8_0.selectGroupCategoryMap and arg_8_0.selectGroupCategoryMap[var_8_1] then
			arg_8_0.selectGroupCategoryMap[var_8_1][arg_8_1] = nil
		end
	end
end

function var_0_0.setTab(arg_9_0, arg_9_1)
	arg_9_0._curCategory = arg_9_1

	arg_9_0:refreshTabData()
end

function var_0_0.setIsSelectGroup(arg_10_0, arg_10_1)
	arg_10_0.isGroup = arg_10_1

	arg_10_0:refreshTabData()
end

function var_0_0.refreshTabData(arg_11_0)
	if not arg_11_0.infoDict then
		return
	end

	local var_11_0 = arg_11_0.isGroup and arg_11_0.moTypeGroupCache or arg_11_0.moTypeCache
	local var_11_1 = var_11_0[arg_11_0._curCategory]

	if not var_11_1 then
		if arg_11_0.isGroup then
			var_11_1 = arg_11_0:buildGroupMOList(arg_11_0._curCategory)
		else
			var_11_1 = arg_11_0:buildSingleMOList(arg_11_0._curCategory)
		end

		var_11_0[arg_11_0._curCategory] = var_11_1
	end

	arg_11_0:setList(var_11_1)
end

function var_0_0.buildSingleMOList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = arg_12_0.infoDict[arg_12_1]

	if not var_12_2 then
		return var_12_0
	end

	table.sort(var_12_2, arg_12_0.sortAchievement)

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		if AchievementModel.instance:getAchievementLevel(iter_12_1.id) > 0 then
			if #var_12_1 >= AchievementEnum.MainListLineCount then
				arg_12_0:buildMO(var_12_0, var_12_1, 0)

				var_12_1 = {}
			end

			table.insert(var_12_1, iter_12_1)
		end
	end

	if #var_12_1 > 0 then
		arg_12_0:buildMO(var_12_0, var_12_1, 0)
	end

	return var_12_0
end

function var_0_0.buildGroupMOList(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = arg_13_0.infoDict[arg_13_1]

	if not var_13_2 then
		return var_13_0
	end

	table.sort(var_13_2, arg_13_0.sortAchievement)

	local var_13_3 = 0

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if AchievementUtils.isActivityGroup(iter_13_1.id) then
			if var_13_3 ~= iter_13_1.groupId then
				if var_13_3 == 0 then
					var_13_3 = iter_13_1.groupId
				else
					arg_13_0:buildMO(var_13_0, var_13_1, var_13_3)

					var_13_1 = {}
					var_13_3 = iter_13_1.groupId
				end
			end

			table.insert(var_13_1, iter_13_1)
		end
	end

	if #var_13_1 > 0 then
		arg_13_0:buildMO(var_13_0, var_13_1, var_13_3)
	end

	return var_13_0
end

function var_0_0.buildMO(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3 ~= 0 then
		local var_14_0 = false

		for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
			if AchievementModel.instance:getAchievementLevel(iter_14_1.id) > 0 then
				var_14_0 = true

				break
			end
		end

		if not var_14_0 then
			return
		end
	end

	local var_14_1 = AchievementTileMO.New()

	var_14_1:init(arg_14_2, arg_14_3)
	table.insert(arg_14_1, var_14_1)
end

function var_0_0.sortAchievement(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.instance:checkIsSelected(arg_15_0)
	local var_15_1 = var_0_0.instance:checkIsSelected(arg_15_1)

	if var_15_0 ~= var_15_1 then
		return var_15_0
	elseif var_15_0 and var_15_1 then
		local var_15_2 = var_0_0.instance.isGroup
		local var_15_3 = var_15_2 and var_0_0.instance.groupSelectList or var_0_0.instance.singleSelectList

		return (tabletool.indexOf(var_15_3, var_15_2 and arg_15_0.groupId or arg_15_0.id) or 0) < (tabletool.indexOf(var_15_3, var_15_2 and arg_15_1.groupId or arg_15_1.id) or 0)
	end

	local var_15_4 = arg_15_0.groupId ~= 0

	if var_15_4 ~= (arg_15_1.groupId ~= 0) then
		return not var_15_4
	end

	if var_15_4 then
		if arg_15_0.groupId ~= arg_15_1.groupId then
			local var_15_5 = AchievementConfig.instance:getGroup(arg_15_0.groupId)
			local var_15_6 = AchievementConfig.instance:getGroup(arg_15_1.groupId)

			if var_15_5 and var_15_6 and var_15_5.order ~= var_15_6.order then
				return var_15_5.order < var_15_6.order
			end

			return arg_15_0.groupId < arg_15_1.groupId
		end

		if arg_15_0.order ~= arg_15_1.order then
			return arg_15_0.order < arg_15_1.order
		end
	end

	return arg_15_0.id < arg_15_1.id
end

function var_0_0.checkIsSelected(arg_16_0, arg_16_1)
	if arg_16_0.isGroup and arg_16_1.groupId ~= 0 then
		return arg_16_0:isGroupSelected(arg_16_1.groupId)
	else
		local var_16_0 = AchievementConfig.instance:getTasksByAchievementId(arg_16_1.id)

		if var_16_0 then
			for iter_16_0, iter_16_1 in pairs(var_16_0) do
				if arg_16_0:isSingleSelected(iter_16_1.id) then
					return true
				end
			end
		end

		return false
	end
end

function var_0_0.getInfoList(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = arg_17_0:getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_2 = SLFramework.UGUI.MixCellInfo.New(iter_17_0, iter_17_1:getLineHeight(), iter_17_0)

		table.insert(var_17_0, var_17_2)
	end

	return var_17_0
end

function var_0_0.isSingleSelected(arg_18_0, arg_18_1)
	local var_18_0 = AchievementConfig.instance:getTask(arg_18_1)

	if var_18_0 then
		return arg_18_0.singleSet[var_18_0.achievementId]
	end

	return false
end

function var_0_0.getSelectOrderIndex(arg_19_0, arg_19_1)
	local var_19_0 = AchievementConfig.instance:getTask(arg_19_1)

	if var_19_0 then
		return tabletool.indexOf(arg_19_0.singleSelectList, var_19_0.achievementId)
	end
end

function var_0_0.isGroupSelected(arg_20_0, arg_20_1)
	return arg_20_0.groupSet[arg_20_1]
end

function var_0_0.getSingleSelectedCount(arg_21_0)
	return tabletool.len(arg_21_0.singleSet)
end

function var_0_0.getGroupSelectedCount(arg_22_0)
	return tabletool.len(arg_22_0.groupSet)
end

function var_0_0.setSingleSelect(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = AchievementConfig.instance:getTask(arg_23_1)

	if not var_23_0 then
		return
	end

	tabletool.removeValue(arg_23_0.singleSelectList, var_23_0.achievementId)

	if arg_23_2 then
		arg_23_0.singleSet[var_23_0.achievementId] = true

		table.insert(arg_23_0.singleSelectList, var_23_0.achievementId)
	else
		arg_23_0.singleSet[var_23_0.achievementId] = nil
	end

	arg_23_0:updateSingleSelectCategoryMap(var_23_0.achievementId, arg_23_2)
end

function var_0_0.setGroupSelect(arg_24_0, arg_24_1, arg_24_2)
	tabletool.removeValue(arg_24_0.groupSelectList, arg_24_1)

	if arg_24_2 then
		arg_24_0.groupSet[arg_24_1] = true

		table.insert(arg_24_0.groupSelectList, arg_24_1)
	else
		arg_24_0.groupSet[arg_24_1] = nil
	end

	arg_24_0:updateGroupSelectCategoryMap(arg_24_1, arg_24_2)
end

function var_0_0.getSaveRequestParam(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = 0

	if arg_25_0.isGroup then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0.groupSelectList) do
			arg_25_0:fillGroupTaskIds(var_25_0, iter_25_1)

			var_25_1 = iter_25_1
		end
	else
		for iter_25_2, iter_25_3 in ipairs(arg_25_0.singleSelectList) do
			arg_25_0:fillSingleTaskId(var_25_0, iter_25_3)
		end
	end

	return var_25_0, var_25_1
end

function var_0_0.getCurrentCategory(arg_26_0)
	return arg_26_0._curCategory
end

function var_0_0.fillGroupTaskIds(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_27_2)

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		arg_27_0:fillSingleTaskId(arg_27_1, iter_27_1.id)
	end
end

function var_0_0.fillSingleTaskId(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = AchievementModel.instance:getAchievementLevel(arg_28_2)

	if var_28_0 > 0 then
		local var_28_1 = AchievementConfig.instance:getTaskByAchievementLevel(arg_28_2, var_28_0)

		if var_28_1 ~= nil then
			table.insert(arg_28_1, var_28_1.id)
		end
	end
end

function var_0_0.checkDirty(arg_29_0, arg_29_1)
	if arg_29_1 then
		if tabletool.len(arg_29_0.groupSet) == tabletool.len(arg_29_0.originGroupSet) then
			for iter_29_0, iter_29_1 in pairs(arg_29_0.groupSet) do
				if iter_29_1 ~= arg_29_0.originGroupSet[iter_29_0] then
					return true
				end
			end
		else
			return true
		end
	elseif #arg_29_0.singleSelectList == #arg_29_0.originSingleSelectList then
		for iter_29_2, iter_29_3 in ipairs(arg_29_0.singleSelectList) do
			if iter_29_3 ~= arg_29_0.originSingleSelectList[iter_29_2] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function var_0_0.clearAllSelect(arg_30_0)
	arg_30_0.singleSet = {}
	arg_30_0.singleSelectList = {}
	arg_30_0.groupSet = {}
	arg_30_0.groupSelectList = {}
	arg_30_0.selectSingleCategoryMap = {}
	arg_30_0.selectGroupCategoryMap = {}
end

function var_0_0.getSelectCount(arg_31_0)
	if arg_31_0.isGroup then
		return arg_31_0.groupSet and tabletool.len(arg_31_0.groupSet) or 0
	else
		return arg_31_0.singleSet and tabletool.len(arg_31_0.singleSet) or 0
	end
end

function var_0_0.getSelectCountByCategory(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.isGroup and arg_32_0.selectGroupCategoryMap or arg_32_0.selectSingleCategoryMap
	local var_32_1 = var_32_0 and var_32_0[arg_32_1]

	return var_32_1 and tabletool.len(var_32_1) or 0
end

function var_0_0.getItemAniHasShownIndex(arg_33_0)
	return arg_33_0._itemAniHasShownIndex
end

function var_0_0.setItemAniHasShownIndex(arg_34_0, arg_34_1)
	arg_34_0._itemAniHasShownIndex = arg_34_1 or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
