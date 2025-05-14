module("modules.logic.meilanni.config.MeilanniConfig", package.seeall)

local var_0_0 = class("MeilanniConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity108_map",
		"activity108_episode",
		"activity108_event",
		"activity108_dialog",
		"activity108_grade",
		"activity108_rule",
		"activity108_story",
		"activity108_score"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity108_dialog" then
		arg_3_0:_initDialog()
	elseif arg_3_1 == "activity108_episode" then
		arg_3_0._episodeConfig = arg_3_2

		arg_3_0:_initEpisode()
	elseif arg_3_1 == "activity108_event" then
		arg_3_0:_initEvent()
	elseif arg_3_1 == "activity108_story" then
		arg_3_0:_initStory()
	elseif arg_3_1 == "activity108_grade" then
		arg_3_0:_initGrade()
	elseif arg_3_1 == "activity108_score" then
		-- block empty
	end
end

function var_0_0._initEpisode(arg_4_0)
	arg_4_0._mapLastEpisode = {}

	for iter_4_0, iter_4_1 in ipairs(lua_activity108_episode.configList) do
		local var_4_0 = arg_4_0._mapLastEpisode[iter_4_1.mapId] or iter_4_1

		if iter_4_1.id > var_4_0.id then
			var_4_0 = iter_4_1
		end

		arg_4_0._mapLastEpisode[var_4_0.mapId] = var_4_0
	end
end

function var_0_0.getLastEpisode(arg_5_0, arg_5_1)
	return arg_5_0._mapLastEpisode[arg_5_1]
end

function var_0_0.getLastEvent(arg_6_0, arg_6_1)
	return arg_6_0._mapLastEvent[arg_6_1]
end

function var_0_0._initEvent(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(lua_activity108_map.configList) do
		local var_7_1 = arg_7_0:getLastEpisode(iter_7_1.id)

		if var_7_1 then
			var_7_0[var_7_1.id] = var_7_1
		end
	end

	arg_7_0._mapLastEvent = {}

	for iter_7_2, iter_7_3 in ipairs(lua_activity108_event.configList) do
		local var_7_2 = var_7_0[iter_7_3.episodeId]

		if var_7_2 then
			arg_7_0._mapLastEvent[var_7_2.mapId] = iter_7_3
		end
	end
end

function var_0_0._initStory(arg_8_0)
	arg_8_0._storyList = {}

	for iter_8_0, iter_8_1 in ipairs(lua_activity108_story.configList) do
		local var_8_0 = string.splitToNumber(iter_8_1.params, "#")
		local var_8_1 = var_8_0[1]
		local var_8_2 = var_8_0[2]
		local var_8_3 = var_8_0[3]
		local var_8_4 = arg_8_0._storyList[var_8_1] or {}

		arg_8_0._storyList[var_8_1] = var_8_4

		table.insert(var_8_4, {
			iter_8_1,
			var_8_2,
			var_8_3
		})
	end
end

function var_0_0.getStoryList(arg_9_0, arg_9_1)
	return arg_9_0._storyList[arg_9_1]
end

function var_0_0._initGrade(arg_10_0)
	arg_10_0._gradleList = {}

	for iter_10_0, iter_10_1 in ipairs(lua_activity108_grade.configList) do
		local var_10_0 = arg_10_0._gradleList[iter_10_1.mapId] or {}

		table.insert(var_10_0, 1, iter_10_1)

		arg_10_0._gradleList[iter_10_1.mapId] = var_10_0
	end
end

function var_0_0.getScoreIndex(arg_11_0, arg_11_1)
	arg_11_1 = math.min(arg_11_1, 100)

	local var_11_0 = #lua_activity108_score.configList

	for iter_11_0, iter_11_1 in ipairs(lua_activity108_score.configList) do
		if arg_11_1 >= iter_11_1.minScore and arg_11_1 <= iter_11_1.maxScore then
			return var_11_0 - iter_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.getGradleIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._gradleList[arg_12_1]

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if arg_12_2 >= iter_12_1.score then
			return iter_12_0
		end
	end

	return #var_12_0
end

function var_0_0.getGradleList(arg_13_0, arg_13_1)
	return arg_13_0._gradleList[arg_13_1]
end

function var_0_0._initDialog(arg_14_0)
	arg_14_0._dialogList = {}

	local var_14_0
	local var_14_1 = "0"

	for iter_14_0, iter_14_1 in ipairs(lua_activity108_dialog.configList) do
		local var_14_2 = arg_14_0._dialogList[iter_14_1.id]

		if not var_14_2 then
			var_14_2 = {}
			var_14_0 = var_14_1
			arg_14_0._dialogList[iter_14_1.id] = var_14_2
		end

		if iter_14_1.type == "selector" then
			var_14_0 = iter_14_1.param
			var_14_2[var_14_0] = var_14_2[var_14_0] or {}
			var_14_2[var_14_0].type = iter_14_1.type
			var_14_2[var_14_0].option_param = iter_14_1.option_param
			var_14_2[var_14_0].result = iter_14_1.result
		elseif iter_14_1.type == "selectorend" then
			var_14_0 = var_14_1
		elseif iter_14_1.type == "random" then
			local var_14_3 = iter_14_1.param

			var_14_2[var_14_3] = var_14_2[var_14_3] or {}
			var_14_2[var_14_3].type = iter_14_1.type
			var_14_2[var_14_3].option_param = iter_14_1.option_param

			table.insert(var_14_2[var_14_3], iter_14_1)
		elseif iter_14_1.stepId > 0 then
			var_14_2[var_14_0] = var_14_2[var_14_0] or {}

			table.insert(var_14_2[var_14_0], iter_14_1)
		end
	end
end

function var_0_0.getDialog(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._dialogList[arg_15_1]

	return var_15_0 and var_15_0[arg_15_2]
end

function var_0_0.getElementConfig(arg_16_0, arg_16_1)
	local var_16_0 = lua_activity108_event.configDict[arg_16_1]

	if not var_16_0 then
		logError(string.format("getElementConfig no config id:%s", arg_16_1))
	end

	return var_16_0
end

function var_0_0.getEpisodeConfig(arg_17_0, arg_17_1)
	return arg_17_0._episodeConfig.configDict[arg_17_1]
end

function var_0_0.getEpisodeConfigListByMapId(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._episodeConfig.configList) do
		if iter_18_1.mapId == arg_18_1 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
