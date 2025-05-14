module("modules.logic.task.config.TaskConfig", package.seeall)

local var_0_0 = string.format
local var_0_1 = class("TaskConfig", BaseConfig)

function var_0_1.ctor(arg_1_0)
	arg_1_0.taskdailyConfig = nil
	arg_1_0.taskweeklyConfig = nil
	arg_1_0.taskactivitybonusConfig = nil
	arg_1_0.taskachievementConfig = nil
	arg_1_0.tasknoviceConfig = nil
	arg_1_0.tasktypeConfig = nil
	arg_1_0.taskseasonConfig = nil
	arg_1_0.taskactivityshowConfig = nil
end

function var_0_1.reqConfigNames(arg_2_0)
	return {
		"task_daily",
		"task_weekly",
		"task_activity_bonus",
		"task_achievement",
		"task_guide",
		"task_type",
		"task_room",
		"task_weekwalk",
		"task_season",
		"task_activity_show"
	}
end

function var_0_1.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "task_daily" then
		arg_3_0.taskdailyConfig = arg_3_2
	elseif arg_3_1 == "task_weekly" then
		arg_3_0.taskweeklyConfig = arg_3_2
	elseif arg_3_1 == "task_activity_bonus" then
		arg_3_0.taskactivitybonusConfig = arg_3_2
	elseif arg_3_1 == "task_achievement" then
		arg_3_0.taskachievementConfig = arg_3_2
	elseif arg_3_1 == "task_guide" then
		arg_3_0.tasknoviceConfig = arg_3_2
	elseif arg_3_1 == "task_type" then
		arg_3_0.tasktypeConfig = arg_3_2
	elseif arg_3_1 == "task_room" then
		arg_3_0.taskroomConfig = arg_3_2
	elseif arg_3_1 == "task_weekwalk" then
		arg_3_0:_initWeekWalkTask()
	elseif arg_3_1 == "task_season" then
		arg_3_0.taskseasonConfig = arg_3_2
	elseif arg_3_1 == "task_activity_show" then
		arg_3_0.taskactivityshowConfig = arg_3_2
	end
end

function var_0_1.getSeasonTaskCo(arg_4_0, arg_4_1)
	return arg_4_0.taskseasonConfig.configDict[arg_4_1]
end

function var_0_1.getWeekWalkTaskList(arg_5_0, arg_5_1)
	return arg_5_0._taskTypeList[arg_5_1]
end

function var_0_1._initWeekWalkTask(arg_6_0)
	arg_6_0._taskRewardList = {}
	arg_6_0._taskTypeList = {}

	for iter_6_0, iter_6_1 in ipairs(lua_task_weekwalk.configList) do
		local var_6_0 = arg_6_0._taskTypeList[iter_6_1.minTypeId] or {}

		table.insert(var_6_0, iter_6_1)

		arg_6_0._taskTypeList[iter_6_1.minTypeId] = var_6_0

		arg_6_0:_initTaskReward(iter_6_1)
	end
end

function var_0_1._initTaskReward(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_1.listenerType == "WeekwalkBattle" then
		local var_7_1 = string.split(arg_7_1.listenerParam, "#")

		var_7_0 = tonumber(var_7_1[1])
	else
		var_7_0 = tonumber(arg_7_1.listenerParam)
	end

	if not var_7_0 then
		return
	end

	local var_7_2 = arg_7_1.bonus

	arg_7_0._taskRewardList[var_7_0] = arg_7_0._taskRewardList[var_7_0] or {}

	local var_7_3 = string.split(var_7_2, "|")

	for iter_7_0 = 1, #var_7_3 do
		local var_7_4 = string.splitToNumber(var_7_3[iter_7_0], "#")

		if var_7_4[1] == MaterialEnum.MaterialType.Currency and var_7_4[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			arg_7_0._taskRewardList[var_7_0][arg_7_1.id] = var_7_4[3]
		end
	end
end

function var_0_1.getWeekWalkRewardList(arg_8_0, arg_8_1)
	return arg_8_0._taskRewardList[arg_8_1]
end

function var_0_1.gettaskdailyCO(arg_9_0, arg_9_1)
	return arg_9_0.taskdailyConfig.configDict[arg_9_1]
end

function var_0_1.gettaskweeklyCO(arg_10_0, arg_10_1)
	return arg_10_0.taskweeklyConfig.configDict[arg_10_1]
end

function var_0_1.gettaskNoviceConfigs(arg_11_0)
	return arg_11_0.tasknoviceConfig.configDict
end

function var_0_1.gettaskNoviceConfig(arg_12_0, arg_12_1)
	return arg_12_0.tasknoviceConfig.configDict[arg_12_1]
end

function var_0_1.gettaskactivitybonusCO(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.taskactivitybonusConfig.configDict[arg_13_1]

	if var_13_0 then
		return var_13_0[arg_13_2]
	end
end

function var_0_1.getTaskActivityBonusConfig(arg_14_0, arg_14_1)
	return arg_14_0.taskactivitybonusConfig.configDict[arg_14_1]
end

function var_0_1.getTaskBonusValue(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.taskBonusValueDict = arg_15_0.taskBonusValueDict or {}

	if not arg_15_0.taskBonusValueDict[arg_15_1] then
		arg_15_0.taskBonusValueDict[arg_15_1] = {}

		local var_15_0 = arg_15_0:getTaskActivityBonusConfig(arg_15_1)

		if not var_15_0 then
			logError("not found task bonus , type : " .. tostring(arg_15_1))

			return 0
		end

		local var_15_1 = {}

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			table.insert(var_15_1, iter_15_1)
		end

		table.sort(var_15_1, function(arg_16_0, arg_16_1)
			return arg_16_0.id < arg_16_1.id
		end)

		local var_15_2

		for iter_15_2, iter_15_3 in ipairs(var_15_1) do
			arg_15_0.taskBonusValueDict[arg_15_1][iter_15_2] = (var_15_2 and arg_15_0.taskBonusValueDict[arg_15_1][var_15_2] or 0) + iter_15_3.needActivity
			var_15_2 = iter_15_2
		end
	end

	return (arg_15_0.taskBonusValueDict[arg_15_1][arg_15_2 - 1] or 0) + arg_15_3
end

function var_0_1.gettaskachievementCO(arg_17_0, arg_17_1)
	return arg_17_0.taskachievementConfig.configDict[arg_17_1]
end

function var_0_1.gettasktypeCO(arg_18_0, arg_18_1)
	return arg_18_0.tasktypeConfig.configDict[arg_18_1]
end

function var_0_1.gettaskRoomCO(arg_19_0, arg_19_1)
	return arg_19_0.taskroomConfig.configDict[arg_19_1]
end

function var_0_1.gettaskroomlist(arg_20_0)
	return arg_20_0.taskroomConfig.configList
end

function var_0_1.getTaskActivityShowConfig(arg_21_0, arg_21_1)
	return arg_21_0.taskactivityshowConfig.configDict[arg_21_1]
end

local var_0_2 = "ReadTask"

function var_0_1.initReadTaskList(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0
	local var_22_1

	if isDebugBuild then
		var_22_1 = ConfigsCheckerMgr.instance:createStrBuf(arg_22_1)
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_4.configList) do
		local var_22_2 = iter_22_1.activityId
		local var_22_3 = arg_22_2[var_22_2]

		if not var_22_3 then
			var_22_3 = {}

			for iter_22_2, iter_22_3 in pairs(arg_22_3) do
				if isDebugBuild then
					var_22_1:appendLineIfOK(var_22_3[iter_22_3], var_0_0("redefined enum enumKey: %s, enumValue: %s", iter_22_2, iter_22_3))
				end

				var_22_3[iter_22_3] = {}
			end

			arg_22_2[var_22_2] = var_22_3
		end

		if iter_22_1.isOnline then
			local var_22_4 = iter_22_1.id

			if iter_22_1.listenerType == var_0_2 then
				local var_22_5 = arg_22_3[iter_22_1.tag]

				if not var_22_5 then
					local var_22_6 = var_0_0("[TaskConfig]: error actId: %s, taskId: %s", var_22_2, var_22_4)

					if isDebugBuild then
						var_22_1:appendLine(var_22_6)
					end

					logError(var_22_6)
				else
					local var_22_7 = var_22_3[var_22_5]

					if var_22_7 then
						var_22_7[var_22_4] = iter_22_1
					else
						local var_22_8 = var_0_0("[TaskConfig]: unsupported actId: %s, tag: %s", var_22_2, iter_22_1.tag)

						if isDebugBuild then
							var_22_1:appendLine(var_22_8)
						end

						logError(var_22_8)
					end
				end
			end
		end
	end

	if isDebugBuild then
		var_22_1:logErrorIfGot()
	end
end

var_0_1.instance = var_0_1.New()

return var_0_1
