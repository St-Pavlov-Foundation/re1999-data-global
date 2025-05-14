module("modules.logic.achievement.model.AchievementMainCommonModel", package.seeall)

local var_0_0 = class("AchievementMainCommonModel", BaseModel)

function var_0_0.initDatas(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._curCategory = arg_1_1 or AchievementEnum.Type.Story
	arg_1_0._curViewType = arg_1_2 or AchievementEnum.ViewType.Tile
	arg_1_0._curSortType = arg_1_3 or AchievementEnum.SortType.RareDown
	arg_1_0._curFilterType = arg_1_4 or AchievementEnum.SearchFilterType.All
	arg_1_0._infoDict = AchievementConfig.instance:getCategoryAchievementMap()
	arg_1_0._categoryAchievementCountMap = {}
	arg_1_0._categoryUnlockAchievementCountMap = {}
	arg_1_0._achievementEffectMap = {}
	arg_1_0._taskEffectMap = {}
	arg_1_0._groupUpgradeEffectMap = {}
	arg_1_0._isCurrentScrollFocusing = false

	arg_1_0:initScrollData()
	arg_1_0:initCategoryNewFlag()
	arg_1_0:refreshScroll()
end

function var_0_0.switchCategory(arg_2_0, arg_2_1)
	if arg_2_0._curCategory ~= arg_2_1 then
		arg_2_0._curCategory = arg_2_1

		arg_2_0:refreshScroll()
	end
end

function var_0_0.switchViewType(arg_3_0, arg_3_1)
	if arg_3_0._curViewType ~= arg_3_1 then
		arg_3_0._curViewType = arg_3_1

		arg_3_0:refreshScroll()
	end
end

function var_0_0.switchSearchFilterType(arg_4_0, arg_4_1)
	if arg_4_0._curFilterType ~= arg_4_1 then
		arg_4_0._curFilterType = arg_4_1

		arg_4_0:refreshScroll()
	end
end

function var_0_0.initScrollData(arg_5_0)
	AchievementMainTileModel.instance:initDatas()
	AchievementMainListModel.instance:initDatas()
end

function var_0_0.refreshScroll(arg_6_0)
	local var_6_0 = arg_6_0:getViewExcuteModelInstance(arg_6_0._curViewType)
	local var_6_1 = arg_6_0._infoDict[arg_6_0._curCategory]

	var_6_0:refreshTabData(arg_6_0._curCategory, arg_6_0._curSortType, arg_6_0._curFilterType, var_6_1)
end

function var_0_0.initCategoryNewFlag(arg_7_0)
	arg_7_0.categoryNewDict = {}

	for iter_7_0, iter_7_1 in pairs(AchievementEnum.Type) do
		arg_7_0.categoryNewDict[iter_7_1] = arg_7_0:buildCategoryNewFlag(iter_7_1)
	end
end

function var_0_0.buildCategoryNewFlag(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._infoDict[arg_8_1]

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if AchievementModel.instance:achievementHasNew(iter_8_1.id) then
				return true
			end
		end
	end
end

function var_0_0.categoryHasNew(arg_9_0, arg_9_1)
	return arg_9_0.categoryNewDict[arg_9_1]
end

function var_0_0.getCurrentCategory(arg_10_0)
	return arg_10_0._curCategory
end

function var_0_0.getCurrentViewType(arg_11_0)
	return arg_11_0._curViewType
end

function var_0_0.switchSortType(arg_12_0, arg_12_1)
	if arg_12_0._curSortType ~= arg_12_1 then
		arg_12_0._curSortType = arg_12_1

		arg_12_0:refreshScroll()
	end
end

function var_0_0.getViewExcuteModelInstance(arg_13_0, arg_13_1)
	if arg_13_1 == AchievementEnum.ViewType.Tile then
		return AchievementMainTileModel.instance
	else
		return AchievementMainListModel.instance
	end
end

function var_0_0.getCategoryAchievementConfigList(arg_14_0, arg_14_1)
	return arg_14_0._infoDict and arg_14_0._infoDict[arg_14_1]
end

function var_0_0.getCategoryAchievementUnlockInfo(arg_15_0, arg_15_1)
	local var_15_0 = 0
	local var_15_1 = 0

	if not arg_15_0._categoryAchievementCountMap[arg_15_1] then
		var_15_0, var_15_1 = arg_15_0:buildCategoryAchievementCountMap(arg_15_1)
		arg_15_0._categoryAchievementCountMap[arg_15_1] = var_15_0
		arg_15_0._categoryUnlockAchievementCountMap[arg_15_1] = var_15_1
	else
		var_15_0 = arg_15_0._categoryAchievementCountMap[arg_15_1] or 0
		var_15_1 = arg_15_0._categoryUnlockAchievementCountMap[arg_15_1] or 0
	end

	return var_15_0, var_15_1
end

function var_0_0.buildCategoryAchievementCountMap(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getCategoryAchievementConfigList(arg_16_1)
	local var_16_1 = 0
	local var_16_2 = 0

	if var_16_0 then
		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			local var_16_3 = AchievementConfig.instance:getTasksByAchievementId(iter_16_1.id)
			local var_16_4 = false

			if var_16_3 then
				for iter_16_2, iter_16_3 in ipairs(var_16_3) do
					var_16_4 = AchievementModel.instance:isAchievementTaskFinished(iter_16_3.id)

					if var_16_4 then
						break
					end
				end
			end

			var_16_2 = var_16_2 + 1
			var_16_1 = var_16_4 and var_16_1 + 1 or var_16_1
		end
	end

	return var_16_2, var_16_1
end

function var_0_0.getCurrentSortType(arg_17_0)
	return arg_17_0._curSortType
end

function var_0_0.getCurrentScrollType(arg_18_0)
	return arg_18_0._curViewType
end

function var_0_0.getCurrentFilterType(arg_19_0)
	return arg_19_0._curFilterType
end

function var_0_0.getViewAchievementIndex(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:getViewExcuteModelInstance(arg_20_1)
	local var_20_1 = false
	local var_20_2 = 0
	local var_20_3 = 0

	if var_20_0 and var_20_0.getAchievementIndexAndScrollPixel then
		var_20_1, var_20_2, var_20_3 = var_20_0:getAchievementIndexAndScrollPixel(arg_20_2, arg_20_3)
	end

	return var_20_1, var_20_2, var_20_3
end

function var_0_0.getNewestUnlockAchievementId(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._infoDict[arg_21_1]
	local var_21_1 = arg_21_0:getViewExcuteModelInstance(arg_21_0._curViewType):getFitCategoryAchievementCfgs(arg_21_1, arg_21_2, var_21_0)

	if var_21_1 then
		local var_21_2
		local var_21_3

		for iter_21_0, iter_21_1 in ipairs(var_21_1) do
			local var_21_4 = iter_21_1.id

			if not arg_21_0:isAchievementPlayEffect(var_21_4) then
				local var_21_5 = arg_21_0:getAchievementNewFinishedTask(var_21_4)

				if var_21_5 and (not var_21_3 or var_21_3 < var_21_5) then
					var_21_3 = var_21_5
					var_21_2 = var_21_4
				end
			end
		end

		return var_21_2
	end
end

function var_0_0.getAchievementNewFinishedTask(arg_22_0, arg_22_1)
	local var_22_0 = AchievementModel.instance:getAchievementTaskCoList(arg_22_1)
	local var_22_1
	local var_22_2

	if var_22_0 then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			local var_22_3 = iter_22_1.id
			local var_22_4 = AchievementModel.instance:getById(var_22_3)

			if var_22_4 and var_22_4.hasFinished then
				local var_22_5 = var_22_4 and var_22_4.isNew
				local var_22_6 = var_22_4 and var_22_4.finishTime
				local var_22_7 = arg_22_0:isTaskPlayFinishedEffect(var_22_3)

				if var_22_5 and not var_22_7 and (not var_22_1 or var_22_1 < var_22_6) then
					var_22_1 = var_22_6
					var_22_2 = var_22_4.id
				end
			else
				break
			end
		end
	end

	return var_22_1, var_22_2
end

function var_0_0.getNewestUpgradeGroupId(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= AchievementEnum.Type.Activity or arg_23_0._curViewType ~= AchievementEnum.ViewType.Tile then
		return
	end

	local var_23_0 = arg_23_0._infoDict[arg_23_1]
	local var_23_1 = arg_23_0:getViewExcuteModelInstance(arg_23_0._curViewType):getFitCategoryAchievementCfgs(arg_23_1, arg_23_2, var_23_0)

	if var_23_1 then
		local var_23_2
		local var_23_3
		local var_23_4 = {}

		for iter_23_0, iter_23_1 in ipairs(var_23_1) do
			local var_23_5 = iter_23_1 and iter_23_1.groupId
			local var_23_6 = arg_23_0:isGroupPlayUpgradeEffect(var_23_5)

			if var_23_5 ~= 0 and not var_23_4[var_23_5] and not var_23_6 then
				var_23_4[var_23_5] = true

				local var_23_7 = AchievementConfig.instance:getGroup(var_23_5)
				local var_23_8 = var_23_7 and var_23_7.unLockAchievement
				local var_23_9 = AchievementModel.instance:getById(var_23_8)

				if var_23_9 then
					local var_23_10 = var_23_9 and var_23_9.hasFinished
					local var_23_11 = var_23_9 and var_23_9.isNew

					if var_23_10 and var_23_11 then
						local var_23_12 = var_23_9 and var_23_9.finishTime

						if not var_23_3 or var_23_3 < var_23_12 then
							var_23_2 = var_23_5
							var_23_3 = var_23_12
						end
					end
				end
			end
		end

		return var_23_2
	end
end

function var_0_0.isCurrentViewBagEmpty(arg_24_0)
	local var_24_0 = arg_24_0:getViewExcuteModelInstance(arg_24_0._curViewType)
	local var_24_1 = false

	if var_24_0 then
		var_24_1 = var_24_0:getCount() <= 0
	end

	return var_24_1
end

function var_0_0.markAchievementPlayEffect(arg_25_0, arg_25_1)
	arg_25_0._achievementEffectMap = arg_25_0._achievementEffectMap or {}
	arg_25_0._achievementEffectMap[arg_25_1] = true
end

function var_0_0.isAchievementPlayEffect(arg_26_0, arg_26_1)
	return arg_26_0._achievementEffectMap and arg_26_0._achievementEffectMap[arg_26_1]
end

function var_0_0.markTaskPlayFinishedEffect(arg_27_0, arg_27_1)
	arg_27_0._taskEffectMap = arg_27_0._taskEffectMap or {}
	arg_27_0._taskEffectMap[arg_27_1] = true
end

function var_0_0.isTaskPlayFinishedEffect(arg_28_0, arg_28_1)
	return arg_28_0._taskEffectMap and arg_28_0._taskEffectMap[arg_28_1]
end

function var_0_0.markGroupPlayUpgradeEffect(arg_29_0, arg_29_1)
	arg_29_0._groupUpgradeEffectMap = arg_29_0._groupUpgradeEffectMap or {}
	arg_29_0._groupUpgradeEffectMap[arg_29_1] = true
end

function var_0_0.isGroupPlayUpgradeEffect(arg_30_0, arg_30_1)
	return arg_30_0._groupUpgradeEffectMap and arg_30_0._groupUpgradeEffectMap[arg_30_1]
end

function var_0_0.isCurrentScrollFocusing(arg_31_0)
	return arg_31_0._isCurrentScrollFocusing
end

function var_0_0.markCurrentScrollFocusing(arg_32_0, arg_32_1)
	arg_32_0._isCurrentScrollFocusing = arg_32_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
