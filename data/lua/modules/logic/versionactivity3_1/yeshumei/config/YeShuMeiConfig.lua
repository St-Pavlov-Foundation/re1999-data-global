module("modules.logic.versionactivity3_1.yeshumei.config.YeShuMeiConfig", package.seeall)

local var_0_0 = class("YeShuMeiConfig", BaseConfig)

var_0_0._ActivityDataName = "T_lua_YeShuMei_ActivityData"

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity211_game",
		"activity211_episode",
		"activity211_task",
		"activity211_const"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._taskDict = {}
	arg_2_0._gameconfig = {}
	arg_2_0._episodeconfig = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity211_game" then
		arg_3_0._gameconfig = arg_3_2
	elseif arg_3_1 == "activity211_episode" then
		arg_3_0._episodeconfig = arg_3_2
	end
end

function var_0_0._initYeShuMeiLevelData(arg_4_0)
	arg_4_0._yeShuMeiLevelData = {}

	if _G[arg_4_0._ActivityDataName] == nil then
		return
	end

	for iter_4_0 = 1, #T_lua_YeShuMei_ActivityData do
		local var_4_0 = _G[arg_4_0._ActivityDataName][iter_4_0]
		local var_4_1 = YeShuMeiLevelMo.New()

		var_4_1:init(var_4_0)

		arg_4_0._yeShuMeiLevelData[var_4_0.id] = var_4_1
	end
end

function var_0_0.getYeShuMeiLevelData(arg_5_0)
	if arg_5_0._yeShuMeiLevelData == nil then
		arg_5_0:_initYeShuMeiLevelData()
	end

	return arg_5_0._yeShuMeiLevelData
end

function var_0_0.getYeShuMeiLevelDataByLevelId(arg_6_0, arg_6_1)
	if arg_6_0._yeShuMeiLevelData == nil then
		arg_6_0:_initYeShuMeiLevelData()
	end

	return arg_6_0._yeShuMeiLevelData[arg_6_1]
end

function var_0_0.getEpisodeCoList(arg_7_0, arg_7_1)
	if not arg_7_0._episodeDict then
		arg_7_0._episodeDict = {}

		for iter_7_0, iter_7_1 in ipairs(lua_activity211_episode.configList) do
			if not arg_7_0._episodeDict[iter_7_1.activityId] then
				arg_7_0._episodeDict[iter_7_1.activityId] = {}
			end

			table.insert(arg_7_0._episodeDict[iter_7_1.activityId], iter_7_1)
		end
	end

	return arg_7_0._episodeDict[arg_7_1] or {}
end

function var_0_0.getYeShuMeiEpisodeConfigById(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 and arg_8_0._episodeconfig then
		return arg_8_0._episodeconfig.configDict[arg_8_1][arg_8_2]
	end
end

function var_0_0.getYeShuMeiGameConfigById(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_0._gameconfig then
		return arg_9_0._gameconfig.configDict[arg_9_1]
	end
end

function var_0_0.getEpisodeCo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getEpisodeCoList(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1.episodeId == arg_10_2 then
			return iter_10_1
		end
	end
end

function var_0_0.getTaskByActId(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._taskDict[arg_11_1]

	if not var_11_0 then
		var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(lua_activity211_task.configList) do
			if iter_11_1.activityId == arg_11_1 then
				table.insert(var_11_0, iter_11_1)
			end
		end

		arg_11_0._taskDict[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.getStoryBefore(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getEpisodeCo(arg_12_1, arg_12_2)

	return var_12_0 and var_12_0.storyBefore
end

function var_0_0.getStoryClear(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getEpisodeCo(arg_13_1, arg_13_2)

	return var_13_0 and var_13_0.storyClear
end

function var_0_0.getConstValueNumber(arg_14_0, arg_14_1)
	local var_14_0 = VersionActivity3_1Enum.ActivityId.YeShuMei
	local var_14_1 = lua_activity211_const.configDict[var_14_0]

	if var_14_1 == nil then
		logError("activity211_const 没有找到对应的配置 activityId = " .. var_14_0)

		return nil
	end

	local var_14_2 = var_14_1[arg_14_1]

	if var_14_2 == nil then
		logError("activity211_const 没有找到对应的配置 id = " .. arg_14_1)

		return nil
	end

	return tonumber(var_14_2.value)
end

function var_0_0.getConstValue(arg_15_0, arg_15_1)
	local var_15_0 = VersionActivity3_1Enum.ActivityId.YeShuMei
	local var_15_1 = lua_activity211_const.configDict[var_15_0]

	if var_15_1 == nil then
		logError("activity211_const 没有找到对应的配置 id = " .. arg_15_1)
	end

	local var_15_2 = var_15_1[arg_15_1]

	return var_15_2.value, var_15_2.value2
end

function var_0_0.getDragSureRange(arg_16_0)
	return 50
end

var_0_0.instance = var_0_0.New()

return var_0_0
