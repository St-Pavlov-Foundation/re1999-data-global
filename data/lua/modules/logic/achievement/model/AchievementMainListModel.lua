﻿module("modules.logic.achievement.model.AchievementMainListModel", package.seeall)

local var_0_0 = class("AchievementMainListModel", MixScrollModel)

function var_0_0.initDatas(arg_1_0)
	arg_1_0._moCacheMap = {}
	arg_1_0._moGroupMap = {}
	arg_1_0._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	arg_1_0._fitAchievementCfgTab = {}
	arg_1_0._isCurTaskNeedPlayIdleAnim = false
end

function var_0_0.refreshTabData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_0:getAchievementMOList(arg_2_1, arg_2_2, arg_2_3)

	if not var_2_0 then
		local var_2_1 = arg_2_0:getFitCategoryAchievementCfgs(arg_2_1, arg_2_3, arg_2_4)
		local var_2_2 = arg_2_0:getSortFunction(arg_2_2)

		table.sort(var_2_1, var_2_2)

		var_2_0 = arg_2_0:buildAchievementMOList(arg_2_3, arg_2_2, var_2_1)
		arg_2_0._moCacheMap[arg_2_1][arg_2_2][arg_2_3] = var_2_0
	end

	local var_2_3 = arg_2_0:filterFolderAchievement(var_2_0)

	arg_2_0:setList(var_2_3)
end

function var_0_0.getAchievementMOList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._moCacheMap[arg_3_1] = arg_3_0._moCacheMap[arg_3_1] or {}
	arg_3_0._moCacheMap[arg_3_1][arg_3_2] = arg_3_0._moCacheMap[arg_3_1][arg_3_2] or {}

	return arg_3_0._moCacheMap[arg_3_1][arg_3_2][arg_3_3]
end

function var_0_0.getFitCategoryAchievementCfgs(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._fitAchievementCfgTab = arg_4_0._fitAchievementCfgTab or {}

	local var_4_0 = arg_4_0._fitAchievementCfgTab and arg_4_0._fitAchievementCfgTab[arg_4_1]

	if arg_4_3 and not var_4_0 then
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_3) do
			for iter_4_2, iter_4_3 in pairs(AchievementEnum.SearchFilterType) do
				local var_4_2 = arg_4_0:getSearchFilterFunction(iter_4_3)

				var_4_1[iter_4_3] = var_4_1[iter_4_3] or {}

				if var_4_2 and var_4_2(arg_4_0, iter_4_1) then
					table.insert(var_4_1[iter_4_3], iter_4_1)
				end
			end
		end

		arg_4_0._fitAchievementCfgTab[arg_4_1] = var_4_1
	end

	return arg_4_0._fitAchievementCfgTab[arg_4_1][arg_4_2]
end

function var_0_0.getSearchFilterFunction(arg_5_0, arg_5_1)
	if not arg_5_0._searchFilterFuncMap then
		arg_5_0._searchFilterFuncMap = {
			[AchievementEnum.SearchFilterType.Unlocked] = arg_5_0.filterAchievementByUnlocked,
			[AchievementEnum.SearchFilterType.Locked] = arg_5_0.filterAchievementByLocked,
			[AchievementEnum.SearchFilterType.All] = arg_5_0.filterAchievementByAll
		}
	end

	return arg_5_0._searchFilterFuncMap[arg_5_1]
end

function var_0_0.filterAchievementByAll(arg_6_0, arg_6_1)
	return true
end

function var_0_0.filterAchievementByUnlocked(arg_7_0, arg_7_1)
	return not AchievementModel.instance:achievementHasLocked(arg_7_1.id)
end

function var_0_0.filterAchievementByLocked(arg_8_0, arg_8_1)
	local var_8_0 = AchievementConfig.instance:getAchievementMaxLevelTask(arg_8_1.id)
	local var_8_1 = var_8_0 and var_8_0.id

	return not AchievementModel.instance:isAchievementTaskFinished(var_8_1)
end

function var_0_0.buildAchievementMOList(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	if arg_9_3 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_3) do
			local var_9_1 = iter_9_1.groupId
			local var_9_2 = false
			local var_9_3 = AchievementListMO.New()

			if var_9_1 and var_9_1 ~= 0 then
				arg_9_0._moGroupMap[arg_9_1] = arg_9_0._moGroupMap[arg_9_1] or {}
				arg_9_0._moGroupMap[arg_9_1][arg_9_2] = arg_9_0._moGroupMap[arg_9_1][arg_9_2] or {}

				if not arg_9_0._moGroupMap[arg_9_1][arg_9_2][var_9_1] then
					arg_9_0._moGroupMap[arg_9_1][arg_9_2][var_9_1] = {}
					var_9_2 = true
				end

				table.insert(arg_9_0._moGroupMap[arg_9_1][arg_9_2][var_9_1], var_9_3)
			end

			var_9_3:init(iter_9_1.id, var_9_2)
			table.insert(var_9_0, var_9_3)
		end
	end

	return var_9_0
end

function var_0_0.filterFolderAchievement(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if arg_10_1 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			local var_10_1 = iter_10_1:getIsFold()

			if iter_10_1.isGroupTop or not var_10_1 then
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	return var_10_0
end

function var_0_0.getSortFunction(arg_11_0, arg_11_1)
	if not arg_11_0._sortFuncMap then
		arg_11_0._sortFuncMap = {
			[AchievementEnum.SortType.RareDown] = arg_11_0.sortAchievementByRareDown,
			[AchievementEnum.SortType.RareUp] = arg_11_0.sortAchievementByRareUp
		}
	end

	return arg_11_0._sortFuncMap[arg_11_1]
end

function var_0_0.sortAchievementByRareDown(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0 and arg_12_0.id
	local var_12_1 = arg_12_1 and arg_12_1.id

	if arg_12_0.groupId ~= 0 and arg_12_1.groupId ~= 0 then
		local var_12_2 = AchievementConfig.instance:getGroup(arg_12_0.groupId)
		local var_12_3 = AchievementConfig.instance:getGroup(arg_12_1.groupId)
		local var_12_4 = var_12_2 and var_12_2.order or 0
		local var_12_5 = var_12_3 and var_12_3.order or 0

		if var_12_4 ~= var_12_5 then
			return var_12_4 < var_12_5
		end

		if arg_12_0.groupId ~= arg_12_1.groupId then
			return arg_12_0.groupId > arg_12_1.groupId
		end
	end

	local var_12_6 = AchievementModel.instance:achievementHasLocked(var_12_0)

	if var_12_6 ~= AchievementModel.instance:achievementHasLocked(var_12_1) then
		return not var_12_6
	end

	return var_12_0 < var_12_1
end

function var_0_0.sortAchievementByRareUp(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0 and arg_13_0.id
	local var_13_1 = arg_13_1 and arg_13_1.id

	if arg_13_0.groupId ~= 0 and arg_13_1.groupId ~= 0 then
		local var_13_2 = AchievementModel.instance:getGroupLevel(arg_13_0.groupId)
		local var_13_3 = AchievementModel.instance:getGroupLevel(arg_13_1.groupId)

		if var_13_2 ~= var_13_3 then
			if var_13_2 * var_13_3 == 0 then
				return var_13_2 ~= 0
			end

			return var_13_2 < var_13_3
		end

		if arg_13_0.groupId ~= arg_13_1.groupId then
			return arg_13_0.groupId < arg_13_1.groupId
		end
	end

	local var_13_4 = AchievementModel.instance:getAchievementLevel(var_13_0)
	local var_13_5 = AchievementModel.instance:getAchievementLevel(var_13_1)

	if var_13_4 ~= var_13_5 then
		if var_13_4 * var_13_5 == 0 then
			return var_13_4 ~= 0
		end

		return var_13_4 < var_13_5
	end

	return var_13_0 < var_13_1
end

function var_0_0.getInfoList(arg_14_0, arg_14_1)
	local var_14_0 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_14_1 = {}
	local var_14_2 = arg_14_0:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_3 = iter_14_1:getIsFold()
		local var_14_4 = iter_14_1:getLineHeight(var_14_0, var_14_3)
		local var_14_5 = iter_14_1:getAchievementType()
		local var_14_6 = SLFramework.UGUI.MixCellInfo.New(var_14_5, var_14_4, iter_14_0)

		table.insert(var_14_1, var_14_6)
	end

	return var_14_1
end

function var_0_0.getAchievementIndexAndScrollPixel(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = false
	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = arg_15_0:getList()

	if var_15_3 then
		local var_15_4 = AchievementMainCommonModel.instance:getCurrentFilterType()

		for iter_15_0, iter_15_1 in ipairs(var_15_3) do
			if not iter_15_1:isAchievementMatch(arg_15_1, arg_15_2) then
				var_15_2 = var_15_2 + iter_15_1:getLineHeight(var_15_4, iter_15_1:getIsFold())
			else
				var_15_1 = iter_15_0
				var_15_0 = true

				break
			end
		end
	end

	return var_15_0, var_15_1, var_15_2
end

function var_0_0.getGroupMOList(arg_16_0, arg_16_1)
	local var_16_0 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_16_1 = AchievementMainCommonModel.instance:getCurrentSortType()
	local var_16_2 = arg_16_0._moGroupMap[var_16_0] and arg_16_0._moGroupMap[var_16_0][var_16_1]

	return var_16_2 and var_16_2[arg_16_1]
end

function var_0_0.isCurTaskNeedPlayIdleAnim(arg_17_0)
	return arg_17_0._isCurTaskNeedPlayIdleAnim
end

function var_0_0.setIsCurTaskNeedPlayIdleAnim(arg_18_0, arg_18_1)
	arg_18_0._isCurTaskNeedPlayIdleAnim = arg_18_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
