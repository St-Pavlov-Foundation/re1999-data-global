module("modules.logic.achievement.model.mo.AchievementListMO", package.seeall)

local var_0_0 = pureTable("AchievementListMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.taskCfgs = AchievementConfig.instance:getTasksByAchievementId(arg_1_1)
	arg_1_0.achievementCfg = AchievementConfig.instance:getAchievement(arg_1_0.id)

	arg_1_0:buildTaskStateMap()

	arg_1_0.isFold = false
	arg_1_0.isGroupTop = arg_1_2
end

function var_0_0.buildTaskStateMap(arg_2_0)
	arg_2_0._unlockTaskList = {}
	arg_2_0._loackTaskList = {}

	if arg_2_0.taskCfgs then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.taskCfgs) do
			if AchievementModel.instance:isAchievementTaskFinished(iter_2_1.id) then
				table.insert(arg_2_0._unlockTaskList, iter_2_1)
			else
				table.insert(arg_2_0._loackTaskList, iter_2_1)
			end
		end
	end
end

function var_0_0.getTaskListBySearchFilterType(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or AchievementEnum.SearchFilterType.All

	if arg_3_1 == AchievementEnum.SearchFilterType.All then
		return arg_3_0.taskCfgs
	elseif arg_3_1 == AchievementEnum.SearchFilterType.Locked then
		return arg_3_0._loackTaskList
	else
		return arg_3_0._unlockTaskList
	end
end

function var_0_0.getTotalTaskConfigList(arg_4_0)
	return arg_4_0.taskCfgs
end

function var_0_0.getLockTaskList(arg_5_0)
	return arg_5_0._loackTaskList
end

function var_0_0.getUnlockTaskList(arg_6_0)
	return arg_6_0._unlockTaskList
end

function var_0_0.getFilterTaskList(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or AchievementEnum.SortType.RareDown
	arg_7_2 = arg_7_2 or AchievementEnum.SearchFilterType.All

	local var_7_0 = arg_7_0:getTaskListBySearchFilterType(arg_7_2)

	if var_7_0 then
		table.sort(var_7_0, arg_7_0.sortTaskFunction)
	end

	return var_7_0
end

function var_0_0.sortTaskFunction(arg_8_0, arg_8_1)
	local var_8_0 = AchievementModel.instance:isAchievementTaskFinished(arg_8_0.id)
	local var_8_1 = AchievementModel.instance:isAchievementTaskFinished(arg_8_1.id)

	return arg_8_0.id < arg_8_1.id
end

function var_0_0.isAchievementMatch(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = false

	if arg_9_1 == AchievementEnum.AchievementType.Single then
		var_9_0 = arg_9_2 == arg_9_0.id
	else
		local var_9_1 = AchievementConfig.instance:getAchievement(arg_9_0.id)

		var_9_0 = var_9_1 and var_9_1.groupId ~= 0 and var_9_1.groupId == arg_9_2
	end

	return var_9_0
end

function var_0_0.setIsFold(arg_10_0, arg_10_1)
	arg_10_0.isFold = arg_10_1
end

function var_0_0.getIsFold(arg_11_0)
	return arg_11_0.isFold
end

local var_0_1 = 46
local var_0_2 = 74
local var_0_3 = 206
local var_0_4 = 500
local var_0_5 = 250

function var_0_0.getLineHeightFunction(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 0
	local var_12_1 = arg_12_0:getAchievementType() == AchievementEnum.AchievementType.Group

	if arg_12_2 then
		if var_12_1 then
			var_12_0 = arg_12_0.isGroupTop and var_0_2 or 0
		else
			var_12_0 = var_0_1
		end
	else
		local var_12_2 = arg_12_0:getTaskListBySearchFilterType(arg_12_1)
		local var_12_3 = var_12_2 and #var_12_2 or 0
		local var_12_4 = arg_12_0.isGroupTop and var_0_2 + var_0_1 or var_0_1
		local var_12_5 = arg_12_0.achievementCfg.category == AchievementEnum.Type.NamePlate
		local var_12_6 = var_12_5 and AchievementMainListModel.instance:checkNamePlateShowList()

		if var_12_5 then
			if var_12_6 then
				var_12_0 = var_0_4
			else
				var_12_0 = var_12_3 * var_0_5 + var_12_4
			end
		else
			var_12_0 = var_12_3 * var_0_3 + var_12_4
		end
	end

	return var_12_0
end

function var_0_0.overrideLineHeight(arg_13_0, arg_13_1)
	arg_13_0._cellHeight = arg_13_1
end

function var_0_0.clearOverrideLineHeight(arg_14_0)
	arg_14_0._cellHeight = nil
end

function var_0_0.getLineHeight(arg_15_0, arg_15_1, arg_15_2)
	return (arg_15_0:getLineHeightFunction(arg_15_1, arg_15_2))
end

function var_0_0.getAchievementType(arg_16_0)
	if not arg_16_0._achievementType then
		local var_16_0 = AchievementConfig.instance:getAchievement(arg_16_0.id)

		arg_16_0._achievementType = var_16_0 and var_16_0.groupId ~= 0 and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
	end

	return arg_16_0._achievementType
end

function var_0_0.getGroupId(arg_17_0)
	local var_17_0 = AchievementConfig.instance:getAchievement(arg_17_0.id)

	return var_17_0 and var_17_0.groupId
end

return var_0_0
