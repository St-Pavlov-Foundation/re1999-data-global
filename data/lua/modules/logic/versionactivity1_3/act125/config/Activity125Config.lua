module("modules.logic.versionactivity1_3.act125.config.Activity125Config", package.seeall)

local var_0_0 = class("Activity125Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._configTab = nil
	arg_1_0._channelValueList = {}
	arg_1_0._episodeCount = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity125",
		"activity125_task",
		"activity125_link"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_1, arg_3_2)
	end
end

function var_0_0.onactivity125ConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._configTab then
		arg_4_0._configTab = {}
	end

	arg_4_0._configTab[arg_4_1] = arg_4_2.configDict
end

function var_0_0.onactivity125_taskConfigLoaded(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:__initTaskList(arg_5_2)
end

local var_0_1 = string.format
local var_0_2 = "ReadTask"

function var_0_0.__initTaskList(arg_6_0, arg_6_1)
	arg_6_0.__ReadTasksTagTaskCoDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.configList) do
		local var_6_0 = iter_6_1.activityId
		local var_6_1 = arg_6_0.__ReadTasksTagTaskCoDict[var_6_0]

		if not var_6_1 then
			var_6_1 = {}

			for iter_6_2, iter_6_3 in pairs(ActivityWarmUpEnum.Activity125TaskTag) do
				if isDebugBuild and var_6_1[iter_6_3] then
					logError(var_0_1("[Activity125Config]: ActivityWarmUpEnum.Activity125TaskTag error redefined enum value: enum=%s, enum value = %s", iter_6_2, iter_6_3))
				end

				var_6_1[iter_6_3] = {}
			end

			arg_6_0.__ReadTasksTagTaskCoDict[var_6_0] = var_6_1
		end

		if iter_6_1.isOnline then
			local var_6_2 = iter_6_1.id

			if iter_6_1.listenerType == var_0_2 then
				local var_6_3 = ActivityWarmUpEnum.Activity125TaskTag[iter_6_1.tag]

				if not var_6_3 then
					logError(var_0_1("[Activity125Config]: lua_activity125_task error actId: %s, id: %s", var_6_0, var_6_2))
				else
					local var_6_4 = var_6_1[var_6_3]

					if var_6_4 then
						var_6_4[var_6_2] = iter_6_1
					else
						logError(var_0_1("[Activity125Config]: unsupported lua_activity125_task actId: %s tag: %s", var_6_0, var_6_3))
					end
				end
			end
		end
	end
end

function var_0_0.getActConfig(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_2 and arg_7_0._configTab and arg_7_0._configTab[arg_7_1] then
		return arg_7_0._configTab[arg_7_1][arg_7_2]
	end

	return nil
end

function var_0_0.getAct125Config(arg_8_0, arg_8_1)
	return arg_8_0:getActConfig("activity125", arg_8_1)
end

function var_0_0.getEpisodeConfig(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:getAct125Config(arg_9_1)[arg_9_2]
end

var_0_0.ChannelCfgType = {
	Range = "Range",
	Point = "Point"
}

function var_0_0.parseChannelCfg(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = GameUtil.splitString2(arg_10_1, false, "|", "#")
	local var_10_1 = {}
	local var_10_2 = 0
	local var_10_3 = #var_10_0
	local var_10_4

	for iter_10_0 = 1, var_10_3 do
		local var_10_5 = var_10_0[iter_10_0]

		var_10_1[iter_10_0] = {}

		local var_10_6 = #var_10_5

		var_10_1[iter_10_0].startIndex = tonumber(var_10_5[1])
		var_10_1[iter_10_0].startValue = var_10_5[2]

		if var_10_6 == 2 then
			var_10_1[iter_10_0].lastIndex = var_10_2
			var_10_2 = var_10_1[iter_10_0].startIndex
			var_10_1[iter_10_0].type = var_0_0.ChannelCfgType.Point
		elseif var_10_6 == 4 then
			var_10_1[iter_10_0].endIndex = tonumber(var_10_5[3])
			var_10_1[iter_10_0].endValue = var_10_5[4]
			var_10_2 = var_10_1[iter_10_0].endIndex
			var_10_1[iter_10_0].type = var_0_0.ChannelCfgType.Range
		else
			logError("config error")
		end

		if not var_10_4 then
			local var_10_7 = var_10_1[iter_10_0].startIndex
			local var_10_8 = var_10_1[iter_10_0].endIndex
			local var_10_9 = var_10_1[iter_10_0].startValue
			local var_10_10 = var_10_1[iter_10_0].endValue

			var_10_4 = arg_10_0:getRealFrequencyValue(arg_10_2, var_10_7, var_10_9, var_10_8, var_10_10) or var_10_4
		end
	end

	var_10_1.targetFrequencyValue = var_10_4
	var_10_1.wholeEndIndex = var_10_2
	var_10_1.wholeStartIndex = var_10_1[1].startIndex

	return var_10_1
end

function var_0_0.getChannelParseResult(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._channelValueList and arg_11_0._channelValueList[arg_11_2]
	local var_11_1 = arg_11_0:getEpisodeConfig(arg_11_1, arg_11_2).frequency

	if not var_11_0 then
		local var_11_2 = arg_11_0:getEpisodeConfig(arg_11_1, arg_11_2).targetFrequency

		arg_11_0._channelValueList[arg_11_2] = var_0_0.instance:parseChannelCfg(var_11_1, var_11_2)
		var_11_0 = arg_11_0._channelValueList[arg_11_2]
	end

	return var_11_0
end

function var_0_0.getRealFrequencyValue(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if not arg_12_4 or not arg_12_5 then
		return arg_12_1 == arg_12_2 and arg_12_3 or nil
	end

	if arg_12_1 < arg_12_2 or arg_12_4 < arg_12_1 then
		return nil
	end

	return (arg_12_5 - arg_12_3) / (arg_12_4 - arg_12_2) * (arg_12_1 - arg_12_2) + arg_12_3
end

function var_0_0.getChannelIndexRange(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:getChannelParseResult(arg_13_1, arg_13_2).wholeStartIndex, arg_13_0:getChannelParseResult(arg_13_1, arg_13_2).wholeEndIndex
end

function var_0_0.getEpisodeCount(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._episodeCount or tabletool.len(arg_14_0:getAct125Config(arg_14_1))

	arg_14_0._episodeCount = var_14_0

	return var_14_0
end

function var_0_0.getTaskCO(arg_15_0, arg_15_1)
	return lua_activity125_task.configDict[arg_15_1]
end

function var_0_0.getTaskCO_ReadTask(arg_16_0, arg_16_1)
	return arg_16_0.__ReadTasksTagTaskCoDict[arg_16_1]
end

function var_0_0.getTaskCO_ReadTask_Tag(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0:getTaskCO_ReadTask(arg_17_1)[arg_17_2]
end

function var_0_0.getTaskCO_ReadTask_Tag_TaskId(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return arg_18_0:getTaskCO_ReadTask_Tag(arg_18_1, arg_18_2)[arg_18_3]
end

function var_0_0.getLinkCO(arg_19_0, arg_19_1)
	return lua_activity125_link.configDict[arg_19_1]
end

function var_0_0.getH5BaseUrl(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getLinkCO(arg_20_1)

	if not var_20_0 then
		return
	end

	return SettingsModel.instance:extractByRegion(var_20_0.link)
end

var_0_0.instance = var_0_0.New()

return var_0_0
