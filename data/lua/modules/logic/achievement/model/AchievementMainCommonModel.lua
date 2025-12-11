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
	if arg_13_0._curCategory == AchievementEnum.Type.NamePlate then
		return AchievementMainListModel.instance
	elseif arg_13_1 == AchievementEnum.ViewType.Tile then
		return AchievementMainTileModel.instance
	else
		return AchievementMainListModel.instance
	end
end

function var_0_0.getCurViewExcuteModelInstance(arg_14_0)
	return arg_14_0:getViewExcuteModelInstance(arg_14_0._curViewType)
end

function var_0_0.getCategoryAchievementConfigList(arg_15_0, arg_15_1)
	return arg_15_0._infoDict and arg_15_0._infoDict[arg_15_1]
end

function var_0_0.getCategoryAchievementUnlockInfo(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = 0

	if not arg_16_0._categoryAchievementCountMap[arg_16_1] then
		var_16_0, var_16_1 = arg_16_0:buildCategoryAchievementCountMap(arg_16_1)
		arg_16_0._categoryAchievementCountMap[arg_16_1] = var_16_0
		arg_16_0._categoryUnlockAchievementCountMap[arg_16_1] = var_16_1
	else
		var_16_0 = arg_16_0._categoryAchievementCountMap[arg_16_1] or 0
		var_16_1 = arg_16_0._categoryUnlockAchievementCountMap[arg_16_1] or 0
	end

	return var_16_0, var_16_1
end

function var_0_0.buildCategoryAchievementCountMap(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getCategoryAchievementConfigList(arg_17_1)
	local var_17_1 = 0
	local var_17_2 = 0

	if var_17_0 then
		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			local var_17_3 = AchievementConfig.instance:getTasksByAchievementId(iter_17_1.id)
			local var_17_4 = false

			if var_17_3 then
				for iter_17_2, iter_17_3 in ipairs(var_17_3) do
					var_17_4 = AchievementModel.instance:isAchievementTaskFinished(iter_17_3.id)

					if var_17_4 then
						break
					end
				end
			end

			var_17_2 = var_17_2 + 1
			var_17_1 = var_17_4 and var_17_1 + 1 or var_17_1
		end
	end

	return var_17_2, var_17_1
end

function var_0_0.getCurrentSortType(arg_18_0)
	return arg_18_0._curSortType
end

function var_0_0.getCurrentScrollType(arg_19_0)
	return arg_19_0._curViewType
end

function var_0_0.getCurrentFilterType(arg_20_0)
	return arg_20_0._curFilterType
end

function var_0_0.getViewAchievementIndex(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0:getViewExcuteModelInstance(arg_21_1)
	local var_21_1 = false
	local var_21_2 = 0
	local var_21_3 = 0

	if var_21_0 and var_21_0.getAchievementIndexAndScrollPixel then
		var_21_1, var_21_2, var_21_3 = var_21_0:getAchievementIndexAndScrollPixel(arg_21_2, arg_21_3)
	end

	return var_21_1, var_21_2, var_21_3
end

function var_0_0.getNewestUnlockAchievementId(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._infoDict[arg_22_1]
	local var_22_1 = arg_22_0:getViewExcuteModelInstance(arg_22_0._curViewType):getFitCategoryAchievementCfgs(arg_22_1, arg_22_2, var_22_0)

	if var_22_1 then
		local var_22_2
		local var_22_3

		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			local var_22_4 = iter_22_1.id

			if not arg_22_0:isAchievementPlayEffect(var_22_4) then
				local var_22_5 = arg_22_0:getAchievementNewFinishedTask(var_22_4)

				if var_22_5 and (not var_22_3 or var_22_3 < var_22_5) then
					var_22_3 = var_22_5
					var_22_2 = var_22_4
				end
			end
		end

		return var_22_2
	end
end

function var_0_0.getAchievementNewFinishedTask(arg_23_0, arg_23_1)
	local var_23_0 = AchievementModel.instance:getAchievementTaskCoList(arg_23_1)
	local var_23_1
	local var_23_2

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_3 = iter_23_1.id
			local var_23_4 = AchievementModel.instance:getById(var_23_3)

			if var_23_4 and var_23_4.hasFinished then
				local var_23_5 = var_23_4 and var_23_4.isNew
				local var_23_6 = var_23_4 and var_23_4.finishTime
				local var_23_7 = arg_23_0:isTaskPlayFinishedEffect(var_23_3)

				if var_23_5 and not var_23_7 and (not var_23_1 or var_23_1 < var_23_6) then
					var_23_1 = var_23_6
					var_23_2 = var_23_4.id
				end
			else
				break
			end
		end
	end

	return var_23_1, var_23_2
end

function var_0_0.getNewestUpgradeGroupId(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= AchievementEnum.Type.Activity or arg_24_0._curViewType ~= AchievementEnum.ViewType.Tile then
		return
	end

	local var_24_0 = arg_24_0._infoDict[arg_24_1]
	local var_24_1 = arg_24_0:getViewExcuteModelInstance(arg_24_0._curViewType):getFitCategoryAchievementCfgs(arg_24_1, arg_24_2, var_24_0)

	if var_24_1 then
		local var_24_2
		local var_24_3
		local var_24_4 = {}

		for iter_24_0, iter_24_1 in ipairs(var_24_1) do
			local var_24_5 = iter_24_1 and iter_24_1.groupId
			local var_24_6 = arg_24_0:isGroupPlayUpgradeEffect(var_24_5)

			if var_24_5 ~= 0 and not var_24_4[var_24_5] and not var_24_6 then
				var_24_4[var_24_5] = true

				local var_24_7 = AchievementConfig.instance:getGroup(var_24_5)
				local var_24_8 = var_24_7 and var_24_7.unLockAchievement
				local var_24_9 = AchievementModel.instance:getById(var_24_8)

				if var_24_9 then
					local var_24_10 = var_24_9 and var_24_9.hasFinished
					local var_24_11 = var_24_9 and var_24_9.isNew

					if var_24_10 and var_24_11 then
						local var_24_12 = var_24_9 and var_24_9.finishTime

						if not var_24_3 or var_24_3 < var_24_12 then
							var_24_2 = var_24_5
							var_24_3 = var_24_12
						end
					end
				end
			end
		end

		return var_24_2
	end
end

function var_0_0.isCurrentViewBagEmpty(arg_25_0)
	local var_25_0 = arg_25_0:getViewExcuteModelInstance(arg_25_0._curViewType)
	local var_25_1 = false

	if var_25_0 then
		var_25_1 = var_25_0:getCount() <= 0
	end

	return var_25_1
end

function var_0_0.markAchievementPlayEffect(arg_26_0, arg_26_1)
	arg_26_0._achievementEffectMap = arg_26_0._achievementEffectMap or {}
	arg_26_0._achievementEffectMap[arg_26_1] = true
end

function var_0_0.isAchievementPlayEffect(arg_27_0, arg_27_1)
	return arg_27_0._achievementEffectMap and arg_27_0._achievementEffectMap[arg_27_1]
end

function var_0_0.markTaskPlayFinishedEffect(arg_28_0, arg_28_1)
	arg_28_0._taskEffectMap = arg_28_0._taskEffectMap or {}
	arg_28_0._taskEffectMap[arg_28_1] = true
end

function var_0_0.isTaskPlayFinishedEffect(arg_29_0, arg_29_1)
	return arg_29_0._taskEffectMap and arg_29_0._taskEffectMap[arg_29_1]
end

function var_0_0.markGroupPlayUpgradeEffect(arg_30_0, arg_30_1)
	arg_30_0._groupUpgradeEffectMap = arg_30_0._groupUpgradeEffectMap or {}
	arg_30_0._groupUpgradeEffectMap[arg_30_1] = true
end

function var_0_0.isGroupPlayUpgradeEffect(arg_31_0, arg_31_1)
	return arg_31_0._groupUpgradeEffectMap and arg_31_0._groupUpgradeEffectMap[arg_31_1]
end

function var_0_0.isCurrentScrollFocusing(arg_32_0)
	return arg_32_0._isCurrentScrollFocusing
end

function var_0_0.markCurrentScrollFocusing(arg_33_0, arg_33_1)
	arg_33_0._isCurrentScrollFocusing = arg_33_1
end

function var_0_0.checkIsNamePlate(arg_34_0)
	return arg_34_0._curCategory == AchievementEnum.Type.NamePlate
end

var_0_0.instance = var_0_0.New()

return var_0_0
