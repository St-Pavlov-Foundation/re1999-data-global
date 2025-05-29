module("modules.logic.weekwalk_2.config.WeekWalk_2Config", package.seeall)

local var_0_0 = class("WeekWalk_2Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"weekwalk_ver2",
		"weekwalk_ver2_const",
		"task_weekwalk_ver2",
		"weekwalk_ver2_scene",
		"weekwalk_ver2_element",
		"weekwalk_ver2_cup",
		"weekwalk_ver2_skill",
		"weekwalk_ver2_time",
		"task_weekwalk_ver2",
		"weekwalk_ver2_element_res"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "task_weekwalk_ver2" then
		arg_3_0:_initWeekWalkTask()

		return
	end

	if arg_3_1 == "weekwalk_ver2_cup" then
		arg_3_0:_initWeekWalkCup()

		return
	end
end

function var_0_0._initWeekWalkCup(arg_4_0)
	arg_4_0._cupInfoMap = {}

	for iter_4_0, iter_4_1 in ipairs(lua_weekwalk_ver2_cup.configList) do
		arg_4_0._cupInfoMap[iter_4_1.layerId] = arg_4_0._cupInfoMap[iter_4_1.layerId] or {}

		local var_4_0 = arg_4_0._cupInfoMap[iter_4_1.layerId]

		var_4_0[iter_4_1.fightType] = var_4_0[iter_4_1.fightType] or {}

		table.insert(var_4_0[iter_4_1.fightType], iter_4_1)
	end
end

function var_0_0.getCupTask(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._cupInfoMap[arg_5_1]

	return var_5_0 and var_5_0[arg_5_2]
end

function var_0_0.getWeekWalkTaskList(arg_6_0, arg_6_1)
	return arg_6_0._taskTypeList[arg_6_1]
end

function var_0_0._initWeekWalkTask(arg_7_0)
	arg_7_0._taskRewardList = {}
	arg_7_0._taskTypeList = {}

	for iter_7_0, iter_7_1 in ipairs(lua_task_weekwalk_ver2.configList) do
		local var_7_0 = arg_7_0._taskTypeList[iter_7_1.minTypeId] or {}

		table.insert(var_7_0, iter_7_1)

		arg_7_0._taskTypeList[iter_7_1.minTypeId] = var_7_0

		arg_7_0:_initTaskReward(iter_7_1)
	end
end

function var_0_0._initTaskReward(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1.listenerType == "WeekwalkVer2SeasonCup" then
		var_8_0 = tonumber(arg_8_1.listenerParam)
	else
		var_8_0 = tonumber(arg_8_1.layerId)
	end

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_1.bonus

	arg_8_0._taskRewardList[var_8_0] = arg_8_0._taskRewardList[var_8_0] or {}

	local var_8_2 = string.split(var_8_1, "|")

	for iter_8_0 = 1, #var_8_2 do
		local var_8_3 = string.splitToNumber(var_8_2[iter_8_0], "#")

		if var_8_3[1] == MaterialEnum.MaterialType.Currency and var_8_3[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			arg_8_0._taskRewardList[var_8_0][arg_8_1.id] = var_8_3[3]
		end
	end
end

function var_0_0.getWeekWalkRewardList(arg_9_0, arg_9_1)
	return arg_9_0._taskRewardList[arg_9_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
