module("modules.logic.achievement.model.AchievementMainTileModel", package.seeall)

local var_0_0 = class("AchievementMainTileModel", ListScrollModel)

function var_0_0.initDatas(arg_1_0)
	arg_1_0._moCacheMap = {}
	arg_1_0._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	arg_1_0._groupStateMap = {}
	arg_1_0._fitAchievementCfgTab = {}
	arg_1_0._curScrollFocusIndex = 1
	arg_1_0._hasPlayOpenAnim = false
end

function var_0_0.refreshTabData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_0:getAchievementMOList(arg_2_1, arg_2_2, arg_2_3)

	if not var_2_0 then
		local var_2_1 = arg_2_0:getFitCategoryAchievementCfgs(arg_2_1, arg_2_3, arg_2_4)
		local var_2_2 = arg_2_0:getSortFunction(arg_2_2)

		table.sort(var_2_1, var_2_2)

		var_2_0 = arg_2_0:buildAchievementMOList(var_2_1)
		arg_2_0._moCacheMap[arg_2_1][arg_2_2][arg_2_3] = var_2_0
	end

	arg_2_0:setList(var_2_0)
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
	local var_7_0 = arg_7_1.groupId
	local var_7_1 = AchievementUtils.isActivityGroup(arg_7_1.id)
	local var_7_2 = false

	if var_7_1 then
		if arg_7_0._groupStateMap[var_7_0] == nil then
			local var_7_3 = AchievementModel.instance:achievementGroupHasLocked(var_7_0)

			arg_7_0._groupStateMap[var_7_0] = var_7_3
		end

		var_7_2 = not arg_7_0._groupStateMap[var_7_0]
	else
		var_7_2 = not AchievementModel.instance:achievementHasLocked(arg_7_1.id)
	end

	return var_7_2
end

function var_0_0.filterAchievementByLocked(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.groupId
	local var_8_1 = AchievementUtils.isActivityGroup(arg_8_1.id)
	local var_8_2 = false

	if var_8_1 then
		if arg_8_0._groupStateMap[var_8_0] == nil then
			local var_8_3 = AchievementModel.instance:achievementGroupHasLocked(var_8_0)

			arg_8_0._groupStateMap[var_8_0] = var_8_3
		end

		var_8_2 = arg_8_0._groupStateMap[var_8_0]
	else
		var_8_2 = AchievementModel.instance:achievementHasLocked(arg_8_1.id)
	end

	return var_8_2
end

function var_0_0.buildAchievementMOList(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = {}

	if not arg_9_1 then
		return
	end

	local var_9_2 = 0
	local var_9_3 = true

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if var_9_2 == 0 then
			if iter_9_1.groupId ~= 0 or #var_9_1 >= AchievementEnum.MainListLineCount then
				if #var_9_1 > 0 then
					arg_9_0:buildMO(var_9_0, var_9_1, var_9_2)

					var_9_1 = {}
				end

				var_9_2 = iter_9_1.groupId
			end
		else
			local var_9_4 = iter_9_1.category == AchievementEnum.Type.GamePlay and #var_9_1 >= AchievementEnum.MainListLineCount
			local var_9_5 = iter_9_1.groupId ~= var_9_2

			if var_9_5 or var_9_4 then
				arg_9_0:buildMO(var_9_0, var_9_1, var_9_2, var_9_3)

				var_9_2 = iter_9_1.groupId
				var_9_1 = {}
				var_9_3 = var_9_5 and true or false
			end
		end

		table.insert(var_9_1, iter_9_1)
	end

	if #var_9_1 > 0 then
		arg_9_0:buildMO(var_9_0, var_9_1, var_9_2, var_9_3)
	end

	return var_9_0
end

function var_0_0.buildMO(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = AchievementTileMO.New()

	var_10_0:init(arg_10_2, arg_10_3, arg_10_4)
	table.insert(arg_10_1, var_10_0)
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
	local var_12_0 = arg_12_0.groupId ~= 0

	if var_12_0 ~= (arg_12_1.groupId ~= 0) then
		return not var_12_0
	end

	if var_12_0 then
		if arg_12_0.groupId ~= arg_12_1.groupId then
			local var_12_1 = AchievementConfig.instance:getGroup(arg_12_0.groupId)
			local var_12_2 = AchievementConfig.instance:getGroup(arg_12_1.groupId)
			local var_12_3 = var_12_1 and var_12_1.order or 0
			local var_12_4 = var_12_2 and var_12_2.order or 0

			if var_12_3 ~= var_12_4 then
				return var_12_3 < var_12_4
			end

			return arg_12_0.groupId < arg_12_1.groupId
		end

		if arg_12_0.order ~= arg_12_1.order then
			return arg_12_0.order < arg_12_1.order
		end
	else
		local var_12_5 = AchievementModel.instance:achievementHasLocked(arg_12_0.id)

		if var_12_5 ~= AchievementModel.instance:achievementHasLocked(arg_12_1.id) then
			return not var_12_5
		end
	end

	return arg_12_0.id < arg_12_1.id
end

function var_0_0.sortAchievementByRareUp(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.groupId ~= 0

	if var_13_0 ~= (arg_13_1.groupId ~= 0) then
		return not var_13_0
	end

	if var_13_0 then
		if arg_13_0.groupId ~= arg_13_1.groupId then
			local var_13_1 = AchievementModel.instance:getGroupLevel(arg_13_0.groupId)
			local var_13_2 = AchievementModel.instance:getGroupLevel(arg_13_1.groupId)

			if var_13_1 ~= var_13_2 then
				if var_13_1 * var_13_2 == 0 then
					return var_13_1 ~= 0
				end

				return var_13_1 < var_13_2
			end

			return arg_13_0.groupId < arg_13_1.groupId
		end

		return arg_13_0.order < arg_13_1.order
	else
		local var_13_3 = arg_13_0.id
		local var_13_4 = arg_13_1.id
		local var_13_5 = AchievementModel.instance:getAchievementLevel(var_13_3)
		local var_13_6 = AchievementModel.instance:getAchievementLevel(var_13_4)

		if var_13_5 ~= var_13_6 then
			if var_13_5 * var_13_5 == 0 then
				return var_13_5 ~= 0
			end

			return var_13_5 < var_13_6
		end

		return var_13_3 < var_13_4
	end
end

function var_0_0.getInfoList(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = iter_14_1:getIsFold()
		local var_14_3 = iter_14_1:getLineHeight(nil, var_14_2)
		local var_14_4 = SLFramework.UGUI.MixCellInfo.New(iter_14_1:getAchievementType(), var_14_3, iter_14_0)

		table.insert(var_14_0, var_14_4)
	end

	return var_14_0
end

function var_0_0.getAchievementIndexAndScrollPixel(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = false
	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = arg_15_0:getList()

	if var_15_3 then
		for iter_15_0, iter_15_1 in ipairs(var_15_3) do
			if not iter_15_1:isAchievementMatch(arg_15_1, arg_15_2) then
				var_15_2 = var_15_2 + iter_15_1:getLineHeight()
			else
				var_15_1 = iter_15_0
				var_15_0 = true

				break
			end
		end
	end

	return var_15_0, var_15_1, var_15_2
end

function var_0_0.getCurrentAchievementIds(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_16_2 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_16_3 = arg_16_0:getFitCategoryAchievementCfgs(var_16_1, var_16_2)
	local var_16_4 = AchievementMainCommonModel.instance:getCurrentSortType()
	local var_16_5 = arg_16_0:getSortFunction(var_16_4)

	table.sort(var_16_3, var_16_5)

	for iter_16_0, iter_16_1 in ipairs(var_16_3) do
		table.insert(var_16_0, iter_16_1.id)
	end

	return var_16_0
end

function var_0_0.markTaskHasShowNewEffect(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0._newEffectTaskDict = arg_17_0._newEffectTaskDict or {}
		arg_17_0._newEffectTaskDict[arg_17_1] = true
	end
end

function var_0_0.isTaskHasShowNewEffect(arg_18_0, arg_18_1)
	return arg_18_0._newEffectTaskDict and arg_18_0._newEffectTaskDict[arg_18_1]
end

function var_0_0.hasPlayOpenAnim(arg_19_0)
	return arg_19_0._hasPlayOpenAnim
end

function var_0_0.setHasPlayOpenAnim(arg_20_0, arg_20_1)
	arg_20_0._hasPlayOpenAnim = arg_20_1
end

function var_0_0.markScrollFocusIndex(arg_21_0, arg_21_1)
	arg_21_0._curScrollFocusIndex = arg_21_1
end

function var_0_0.getScrollFocusIndex(arg_22_0)
	return arg_22_0._curScrollFocusIndex
end

function var_0_0.resetScrollFocusIndex(arg_23_0)
	arg_23_0._curScrollFocusIndex = nil
end

function var_0_0.getCurGroupMoList(arg_24_0, arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_0:getCurMoList()) do
		if iter_24_1.groupId == arg_24_1 then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0.getCurMoList(arg_25_0)
	local var_25_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_25_1 = AchievementMainCommonModel.instance:getCurrentSortType()
	local var_25_2 = AchievementMainCommonModel.instance:getCurrentFilterType()

	return arg_25_0:getAchievementMOList(var_25_0, var_25_1, var_25_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
