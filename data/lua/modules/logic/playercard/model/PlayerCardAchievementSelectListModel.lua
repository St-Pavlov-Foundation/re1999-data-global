module("modules.logic.playercard.model.PlayerCardAchievementSelectListModel", package.seeall)

local var_0_0 = class("PlayerCardAchievementSelectListModel", ListScrollModel)

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
	local var_4_0 = PlayerCardModel.instance:getShowAchievement()
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

			if var_4_5.groupId ~= 0 and not arg_4_0.groupSet[var_4_5.groupId] then
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

	if arg_9_0:checkIsNamePlate() then
		arg_9_0.isGroup = false
	end

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
		elseif arg_11_0._curCategory == AchievementEnum.Type.NamePlate then
			arg_11_0:clearAllSelect()

			var_11_1 = arg_11_0:buildNamePlateMOList(arg_11_0._curCategory)
		else
			var_11_1 = arg_11_0:buildSingleMOList(arg_11_0._curCategory)
		end

		var_11_0[arg_11_0._curCategory] = var_11_1
	end

	arg_11_0:setList(var_11_1)
end

function var_0_0.buildNamePlateMOList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = arg_12_0.infoDict[arg_12_1]

	if not var_12_2 then
		return var_12_0
	end

	table.sort(var_12_2, arg_12_0.sortAchievement)

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = AchievementModel.instance:getAchievementLevel(iter_12_1.id)
		local var_12_4 = AchievementConfig.instance:getTaskByAchievementLevel(iter_12_1.id, var_12_3)

		if var_12_3 > 0 then
			local var_12_5 = {
				achievementId = iter_12_1.id,
				taskCo = var_12_4,
				maxLevel = var_12_3,
				taskId = var_12_4.id,
				co = iter_12_1
			}

			table.insert(var_12_1, var_12_5)
		end
	end

	if #var_12_1 > 0 then
		arg_12_0:buildMO(var_12_0, var_12_1, 0)
	end

	return var_12_0
end

function var_0_0.buildSingleMOList(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = arg_13_0.infoDict[arg_13_1]

	if not var_13_2 then
		return var_13_0
	end

	table.sort(var_13_2, arg_13_0.sortAchievement)

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if AchievementModel.instance:getAchievementLevel(iter_13_1.id) > 0 then
			if #var_13_1 >= AchievementEnum.MainListLineCount then
				arg_13_0:buildMO(var_13_0, var_13_1, 0)

				var_13_1 = {}
			end

			table.insert(var_13_1, iter_13_1)
		end
	end

	if #var_13_1 > 0 then
		arg_13_0:buildMO(var_13_0, var_13_1, 0)
	end

	return var_13_0
end

function var_0_0.buildGroupMOList(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = arg_14_0.infoDict[arg_14_1]

	if not var_14_2 then
		return var_14_0
	end

	table.sort(var_14_2, arg_14_0.sortAchievement)

	local var_14_3 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		if AchievementUtils.isActivityGroup(iter_14_1.id) then
			if var_14_3 ~= iter_14_1.groupId then
				if var_14_3 == 0 then
					var_14_3 = iter_14_1.groupId
				else
					arg_14_0:buildMO(var_14_0, var_14_1, var_14_3)

					var_14_1 = {}
					var_14_3 = iter_14_1.groupId
				end
			end

			table.insert(var_14_1, iter_14_1)
		end
	end

	if #var_14_1 > 0 then
		arg_14_0:buildMO(var_14_0, var_14_1, var_14_3)
	end

	return var_14_0
end

function var_0_0.buildMO(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3 ~= 0 then
		local var_15_0 = false

		for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
			if AchievementModel.instance:getAchievementLevel(iter_15_1.id) > 0 then
				var_15_0 = true

				break
			end
		end

		if not var_15_0 then
			return
		end
	end

	local var_15_1 = AchievementTileMO.New()

	var_15_1:init(arg_15_2, arg_15_3)
	table.insert(arg_15_1, var_15_1)
end

function var_0_0.sortAchievement(arg_16_0, arg_16_1)
	local var_16_0 = var_0_0.instance:checkIsSelected(arg_16_0)
	local var_16_1 = var_0_0.instance:checkIsSelected(arg_16_1)

	if var_16_0 ~= var_16_1 then
		return var_16_0
	elseif var_16_0 and var_16_1 then
		local var_16_2 = var_0_0.instance.isGroup
		local var_16_3 = var_16_2 and var_0_0.instance.groupSelectList or var_0_0.instance.singleSelectList

		return (tabletool.indexOf(var_16_3, var_16_2 and arg_16_0.groupId or arg_16_0.id) or 0) < (tabletool.indexOf(var_16_3, var_16_2 and arg_16_1.groupId or arg_16_1.id) or 0)
	end

	local var_16_4 = arg_16_0.groupId ~= 0

	if var_16_4 ~= (arg_16_1.groupId ~= 0) then
		return not var_16_4
	end

	if var_16_4 then
		if arg_16_0.groupId ~= arg_16_1.groupId then
			local var_16_5 = AchievementConfig.instance:getGroup(arg_16_0.groupId)
			local var_16_6 = AchievementConfig.instance:getGroup(arg_16_1.groupId)

			if var_16_5 and var_16_6 and var_16_5.order ~= var_16_6.order then
				return var_16_5.order < var_16_6.order
			end

			return arg_16_0.groupId < arg_16_1.groupId
		end

		if arg_16_0.order ~= arg_16_1.order then
			return arg_16_0.order < arg_16_1.order
		end
	end

	return arg_16_0.id < arg_16_1.id
end

function var_0_0.checkIsSelected(arg_17_0, arg_17_1)
	if arg_17_0.isGroup and arg_17_1.groupId ~= 0 then
		return arg_17_0:isGroupSelected(arg_17_1.groupId)
	else
		local var_17_0 = AchievementConfig.instance:getTasksByAchievementId(arg_17_1.id)

		if var_17_0 then
			for iter_17_0, iter_17_1 in pairs(var_17_0) do
				if arg_17_0:isSingleSelected(iter_17_1.id) then
					return true
				end
			end
		end

		return false
	end
end

function var_0_0.getInfoList(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = arg_18_0:getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = SLFramework.UGUI.MixCellInfo.New(iter_18_0, iter_18_1:getLineHeight(), iter_18_0)

		table.insert(var_18_0, var_18_2)
	end

	return var_18_0
end

function var_0_0.isSingleSelected(arg_19_0, arg_19_1)
	local var_19_0 = AchievementConfig.instance:getTask(arg_19_1)

	if var_19_0 then
		return arg_19_0.singleSet[var_19_0.achievementId]
	end

	return false
end

function var_0_0.getSelectOrderIndex(arg_20_0, arg_20_1)
	local var_20_0 = AchievementConfig.instance:getTask(arg_20_1)

	if var_20_0 then
		return tabletool.indexOf(arg_20_0.singleSelectList, var_20_0.achievementId)
	end
end

function var_0_0.isGroupSelected(arg_21_0, arg_21_1)
	return arg_21_0.groupSet[arg_21_1]
end

function var_0_0.getSingleSelectedCount(arg_22_0)
	return tabletool.len(arg_22_0.singleSet)
end

function var_0_0.getGroupSelectedCount(arg_23_0)
	return tabletool.len(arg_23_0.groupSet)
end

function var_0_0.setSingleSelect(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = AchievementConfig.instance:getTask(arg_24_1)

	if not var_24_0 then
		return
	end

	tabletool.removeValue(arg_24_0.singleSelectList, var_24_0.achievementId)

	if arg_24_2 then
		arg_24_0.singleSet[var_24_0.achievementId] = true

		table.insert(arg_24_0.singleSelectList, var_24_0.achievementId)
	else
		arg_24_0.singleSet[var_24_0.achievementId] = nil
	end

	arg_24_0:updateSingleSelectCategoryMap(var_24_0.achievementId, arg_24_2)
end

function var_0_0.setGroupSelect(arg_25_0, arg_25_1, arg_25_2)
	tabletool.removeValue(arg_25_0.groupSelectList, arg_25_1)

	if arg_25_2 then
		arg_25_0.groupSet[arg_25_1] = true

		table.insert(arg_25_0.groupSelectList, arg_25_1)
	else
		arg_25_0.groupSet[arg_25_1] = nil
	end

	arg_25_0:updateGroupSelectCategoryMap(arg_25_1, arg_25_2)
end

function var_0_0.getSaveRequestParam(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = 0

	if arg_26_0.isGroup then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.groupSelectList) do
			arg_26_0:fillGroupTaskIds(var_26_0, iter_26_1)

			var_26_1 = iter_26_1
		end
	else
		for iter_26_2, iter_26_3 in ipairs(arg_26_0.singleSelectList) do
			arg_26_0:fillSingleTaskId(var_26_0, iter_26_3)
		end
	end

	return var_26_0, var_26_1
end

function var_0_0.getCurrentCategory(arg_27_0)
	return arg_27_0._curCategory
end

function var_0_0.checkIsNamePlate(arg_28_0)
	return arg_28_0._curCategory == AchievementEnum.Type.NamePlate
end

function var_0_0.fillGroupTaskIds(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_29_2)

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		arg_29_0:fillSingleTaskId(arg_29_1, iter_29_1.id)
	end
end

function var_0_0.fillSingleTaskId(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = AchievementModel.instance:getAchievementLevel(arg_30_2)

	if var_30_0 > 0 then
		local var_30_1 = AchievementConfig.instance:getTaskByAchievementLevel(arg_30_2, var_30_0)

		if var_30_1 ~= nil then
			table.insert(arg_30_1, var_30_1.id)
		end
	end
end

function var_0_0.checkDirty(arg_31_0, arg_31_1)
	if arg_31_1 then
		if tabletool.len(arg_31_0.groupSet) == tabletool.len(arg_31_0.originGroupSet) then
			for iter_31_0, iter_31_1 in pairs(arg_31_0.groupSet) do
				if iter_31_1 ~= arg_31_0.originGroupSet[iter_31_0] then
					return true
				end
			end
		else
			return true
		end
	elseif #arg_31_0.singleSelectList == #arg_31_0.originSingleSelectList then
		for iter_31_2, iter_31_3 in ipairs(arg_31_0.singleSelectList) do
			if iter_31_3 ~= arg_31_0.originSingleSelectList[iter_31_2] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function var_0_0.clearAllSelect(arg_32_0)
	arg_32_0.singleSet = {}
	arg_32_0.singleSelectList = {}
	arg_32_0.groupSet = {}
	arg_32_0.groupSelectList = {}
	arg_32_0.selectSingleCategoryMap = {}
	arg_32_0.selectGroupCategoryMap = {}
end

function var_0_0.getSelectCount(arg_33_0)
	if arg_33_0.isGroup then
		return arg_33_0.groupSet and tabletool.len(arg_33_0.groupSet) or 0
	else
		return arg_33_0.singleSet and tabletool.len(arg_33_0.singleSet) or 0
	end
end

function var_0_0.getSelectCountByCategory(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.isGroup and arg_34_0.selectGroupCategoryMap or arg_34_0.selectSingleCategoryMap
	local var_34_1 = var_34_0 and var_34_0[arg_34_1]

	return var_34_1 and tabletool.len(var_34_1) or 0
end

function var_0_0.getItemAniHasShownIndex(arg_35_0)
	return arg_35_0._itemAniHasShownIndex
end

function var_0_0.setItemAniHasShownIndex(arg_36_0, arg_36_1)
	arg_36_0._itemAniHasShownIndex = arg_36_1 or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
