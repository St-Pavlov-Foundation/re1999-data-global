module("modules.logic.achievement.config.AchievementConfig", package.seeall)

local var_0_0 = class("AchievementConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._achievementConfig = nil
	arg_1_0._achievementGroupConfig = nil
	arg_1_0._achievementTaskConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"achievement",
		"achievement_group",
		"achievement_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "achievement" then
		arg_3_0:buildAchievementCfgs(arg_3_2)
	elseif arg_3_1 == "achievement_group" then
		arg_3_0._achievementGroupConfig = arg_3_2
	elseif arg_3_1 == "achievement_task" then
		arg_3_0._achievementTaskConfig = arg_3_2

		arg_3_0:initAchievementTask()
	end
end

function var_0_0.buildAchievementCfgs(arg_4_0, arg_4_1)
	arg_4_0._achievementConfig = arg_4_1

	arg_4_0:initAchievementStateDict()
end

function var_0_0.initAchievementStateDict(arg_5_0)
	arg_5_0._achievementState = {}
	arg_5_0._waitOnlineList = {}
	arg_5_0._waitOfflineList = {}

	for iter_5_0, iter_5_1 in pairs(AchievementEnum.AchievementState) do
		arg_5_0._achievementState[iter_5_1] = {}
	end
end

function var_0_0.initWaitAchievements(arg_6_0)
	arg_6_0:initAchievementStateDict()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._achievementConfig.configList) do
		local var_6_0, var_6_1, var_6_2 = arg_6_0:checkAchievementState(iter_6_1)

		table.insert(arg_6_0._achievementState[var_6_0], iter_6_1)

		if var_6_1 then
			table.insert(arg_6_0._waitOnlineList, iter_6_1)
		end

		if var_6_2 then
			table.insert(arg_6_0._waitOfflineList, iter_6_1)
		end
	end
end

function var_0_0.checkAchievementState(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.startTime
	local var_7_1 = arg_7_1.endTime
	local var_7_2
	local var_7_3
	local var_7_4 = AchievementEnum.AchievementState.Online

	if not string.nilorempty(var_7_0) then
		var_7_2 = TimeUtil.stringToTimestamp(var_7_0) + ServerTime.clientToServerOffset()
		var_7_2 = var_7_2 - ServerTime.now()
	end

	if not string.nilorempty(var_7_1) then
		var_7_3 = TimeUtil.stringToTimestamp(var_7_1) + ServerTime.clientToServerOffset()
		var_7_3 = var_7_3 - ServerTime.now()
	end

	if var_7_2 and var_7_3 and var_7_3 <= var_7_2 then
		logError("成就下架时间不可早于或等于成就上架时间,成就id = " .. arg_7_1.id)
	end

	local var_7_5 = var_7_2 and var_7_2 > 0
	local var_7_6 = var_7_3 and var_7_3 > 0

	if var_7_5 or var_7_3 and var_7_3 < 0 then
		var_7_4 = AchievementEnum.AchievementState.Offline
	end

	return var_7_4, var_7_5, var_7_6
end

function var_0_0.initAchievementTask(arg_8_0)
	arg_8_0._taskFirstLevelDict = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._achievementTaskConfig.configList) do
		local var_8_0 = arg_8_0._taskFirstLevelDict[iter_8_1.achievementId] or iter_8_1

		if var_8_0 and var_8_0.level > iter_8_1.level then
			var_8_0 = iter_8_1
		end

		arg_8_0._taskFirstLevelDict[iter_8_1.achievementId] = var_8_0
	end
end

function var_0_0.getAchievement(arg_9_0, arg_9_1)
	return arg_9_0._achievementConfig.configDict[arg_9_1]
end

function var_0_0.getTask(arg_10_0, arg_10_1)
	return arg_10_0._achievementTaskConfig.configDict[arg_10_1]
end

function var_0_0.getGroup(arg_11_0, arg_11_1)
	return arg_11_0._achievementGroupConfig.configDict[arg_11_1]
end

function var_0_0.getGroupName(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.instance:getGroup(arg_12_1)

	if not var_12_0 then
		return luaLang(AchievementEnum.SpGroupNameLangId[arg_12_1])
	end

	return var_12_0 and var_12_0.name
end

function var_0_0.getAchievementFirstTask(arg_13_0, arg_13_1)
	return arg_13_0._taskFirstLevelDict[arg_13_1]
end

function var_0_0.getTaskByAchievementLevel(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._achievementTaskConfig.configList) do
		if iter_14_1.achievementId == arg_14_1 and iter_14_1.level == arg_14_2 then
			return iter_14_1
		end
	end

	return nil
end

function var_0_0.getAchievementMaxLevelTask(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._achievementTaskConfig.configList) do
		if iter_15_1.achievementId == arg_15_1 then
			table.insert(var_15_0, iter_15_1)
		end
	end

	table.sort(var_15_0, arg_15_0.achievementTaskSortFuncByLevel)

	return var_15_0[1]
end

function var_0_0.achievementTaskSortFuncByLevel(arg_16_0, arg_16_1)
	if arg_16_0.level ~= arg_16_1.level then
		return arg_16_0.level > arg_16_1.level
	end

	return arg_16_0.id < arg_16_1.id
end

function var_0_0.getAchievementsByGroupId(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._achievementConfig.configList) do
		if iter_17_1.groupId == arg_17_1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	arg_17_2 = arg_17_2 or var_0_0.achievmentSortFuncInGroup

	table.sort(var_17_0, arg_17_2)

	return var_17_0
end

function var_0_0.achievmentSortFuncInGroup(arg_18_0, arg_18_1)
	if arg_18_0.order ~= arg_18_1.order then
		return arg_18_0.order < arg_18_1.order
	else
		return arg_18_0.id < arg_18_1.id
	end
end

function var_0_0.getTasksByAchievementId(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._achievementTaskConfig.configList) do
		if iter_19_1.achievementId == arg_19_1 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.getAllAchievements(arg_20_0)
	return arg_20_0._achievementConfig.configList
end

function var_0_0.getOnlineAchievements(arg_21_0)
	return arg_21_0._achievementState[AchievementEnum.AchievementState.Online]
end

function var_0_0.getAllTasks(arg_22_0)
	return arg_22_0._achievementTaskConfig.configList
end

function var_0_0.getCategoryAchievementMap(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(AchievementEnum.Type) do
		var_23_0[iter_23_0] = {}
	end

	local var_23_1 = arg_23_0:getOnlineAchievements()

	if var_23_1 then
		for iter_23_2, iter_23_3 in ipairs(var_23_1) do
			var_23_0[iter_23_3.category] = var_23_0[iter_23_3.category] or {}

			local var_23_2 = var_23_0[iter_23_3.category]

			table.insert(var_23_2, iter_23_3)
		end
	end

	return var_23_0
end

function var_0_0.getGroupBgUrl(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0:getGroupEditConfigData(arg_24_1, arg_24_2)

	if var_24_0 then
		return arg_24_3 and var_24_0.groupUpgradeBgUrl or var_24_0.groupNormalBgUrl
	end
end

function var_0_0.getAchievementPosAndScaleInGroup(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0:getGroupEditConfigData(arg_25_1, arg_25_3)

	if var_25_0 and var_25_0.id[arg_25_2] then
		return var_25_0.pX[arg_25_2], var_25_0.pY[arg_25_2], var_25_0.sX[arg_25_2], var_25_0.sY[arg_25_2]
	end
end

function var_0_0.getGroupTitleColorConfig(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getGroupEditConfigData(arg_26_1, arg_26_2)

	if var_26_0 and var_26_0.groupTitleColor then
		return var_26_0.groupTitleColor
	end
end

function var_0_0.getGroupParamIdTab(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:getGroupEditConfigData(arg_27_1, arg_27_2)

	if var_27_0 and var_27_0.id then
		return var_27_0.id
	end
end

function var_0_0.getGroupEditConfigData(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._groupParamTab = arg_28_0._groupParamTab or {}

	if not arg_28_0._groupParamTab[arg_28_1] then
		arg_28_0._groupParamTab[arg_28_1] = {}
	end

	if not arg_28_0._groupParamTab[arg_28_1][arg_28_2] then
		local var_28_0 = arg_28_0:getGroup(arg_28_1)

		if arg_28_2 == AchievementEnum.GroupParamType.List then
			if not string.nilorempty(var_28_0.uiListParam) then
				arg_28_0._groupParamTab[arg_28_1][arg_28_2] = cjson.decode(var_28_0.uiListParam)
			end
		elseif arg_28_2 == AchievementEnum.GroupParamType.Player and not string.nilorempty(var_28_0.uiPlayerParam) then
			arg_28_0._groupParamTab[arg_28_1][arg_28_2] = cjson.decode(var_28_0.uiPlayerParam)
		end
	end

	return arg_28_0._groupParamTab[arg_28_1][arg_28_2]
end

function var_0_0.getWaitOnlineAchievementList(arg_29_0)
	return arg_29_0._waitOnlineList
end

function var_0_0.getWaitOfflineAchievementList(arg_30_0)
	return arg_30_0._waitOfflineList
end

function var_0_0.getStateAchievement(arg_31_0, arg_31_1)
	return arg_31_0._achievementState and arg_31_0._achievementState[arg_31_1]
end

function var_0_0.updateAchievementStateInternal(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_0:getStateAchievement(arg_32_2)

	if var_32_0 then
		tabletool.removeValue(var_32_0, arg_32_1)
	end

	local var_32_1 = arg_32_0:getStateAchievement(arg_32_3)

	table.insert(var_32_1, arg_32_1)
end

function var_0_0.onAchievementArriveOnlineTime(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getAchievement(arg_33_1)

	arg_33_0:updateAchievementStateInternal(var_33_0, AchievementEnum.AchievementState.Offline, AchievementEnum.AchievementState.Online)
	tabletool.removeValue(arg_33_0._waitOnlineList, var_33_0)
end

function var_0_0.onAchievementArriveOfflineTime(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getAchievement(arg_34_1)

	arg_34_0:updateAchievementStateInternal(var_34_0, AchievementEnum.AchievementState.Online, AchievementEnum.AchievementState.Offline)
	tabletool.removeValue(arg_34_0._waitOfflineList, var_34_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
