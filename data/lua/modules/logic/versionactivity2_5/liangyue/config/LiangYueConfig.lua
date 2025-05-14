module("modules.logic.versionactivity2_5.liangyue.config.LiangYueConfig", package.seeall)

local var_0_0 = class("LiangYueConfig", BaseConfig)

var_0_0.EPISODE_CONFIG_NAME = "activity184_episode"
var_0_0.PUZZLE_CONFIG_NAME = "activity184_puzzle_episode"
var_0_0.ILLUSTRATION_CONFIG_NAME = "activity184_illustration"
var_0_0.TASK_CONFIG_NAME = "activity184_task"

function var_0_0.reqConfigNames(arg_1_0)
	return {
		arg_1_0.EPISODE_CONFIG_NAME,
		arg_1_0.ILLUSTRATION_CONFIG_NAME,
		arg_1_0.PUZZLE_CONFIG_NAME,
		arg_1_0.TASK_CONFIG_NAME
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._noGameEpisodeDic = {}
	arg_2_0._afterGameEpisodeDic = {}
	arg_2_0._taskDict = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == arg_3_0.EPISODE_CONFIG_NAME then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == arg_3_0.TASK_CONFIG_NAME then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == arg_3_0.ILLUSTRATION_CONFIG_NAME then
		arg_3_0._illustrationConfig = arg_3_2

		arg_3_0:initIllustrationConfig()
	elseif arg_3_1 == arg_3_0.PUZZLE_CONFIG_NAME then
		arg_3_0._episodePuzzleConfig = arg_3_2

		arg_3_0:initPuzzleEpisodeConfig()
	end
end

function var_0_0.getTaskByActId(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._taskDict[arg_4_1]

	if not var_4_0 then
		var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_0._taskConfig.configList) do
			if iter_4_1.activityId == arg_4_1 then
				table.insert(var_4_0, iter_4_1)
			end
		end

		arg_4_0._taskDict[arg_4_1] = var_4_0
	end

	return var_4_0
end

function var_0_0.initPuzzleEpisodeConfig(arg_5_0)
	arg_5_0._episodeStaticIllustrationDic = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._episodePuzzleConfig.configList) do
		local var_5_0 = iter_5_1.activityId

		if arg_5_0._episodeStaticIllustrationDic[var_5_0] == nil then
			local var_5_1 = {}

			arg_5_0._episodeStaticIllustrationDic[var_5_0] = var_5_1
		end

		if not string.nilorempty(iter_5_1.staticShape) then
			local var_5_2 = string.split(iter_5_1.staticShape, "|")
			local var_5_3 = {}

			for iter_5_2, iter_5_3 in ipairs(var_5_2) do
				local var_5_4 = string.split(iter_5_3, "#")
				local var_5_5 = string.splitToNumber(var_5_4[1], ",")
				local var_5_6 = var_5_5[1]
				local var_5_7 = var_5_5[2]

				if var_5_3[var_5_6] and var_5_3[var_5_6][var_5_7] then
					logError("固定格子位置重复 位置: x:" .. var_5_6 .. "y:" .. var_5_7)
				else
					if not var_5_3[var_5_6] then
						var_5_3[var_5_6] = {}
					end

					var_5_3[var_5_6][var_5_7] = tonumber(var_5_4[2])
				end
			end

			arg_5_0._episodeStaticIllustrationDic[var_5_0][iter_5_1.id] = var_5_3
		end
	end
end

function var_0_0.getFirstEpisodeId(arg_6_0)
	return arg_6_0._episodeConfig.configList[1]
end

function var_0_0.initIllustrationConfig(arg_7_0)
	arg_7_0._illustrationShapeDic = {}
	arg_7_0._illustrationShapeBoxCountDic = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._illustrationConfig.configList) do
		local var_7_0 = iter_7_1.activityId
		local var_7_1 = iter_7_1.id

		if not arg_7_0._illustrationShapeDic[var_7_0] then
			local var_7_2 = {}

			arg_7_0._illustrationShapeDic[var_7_0] = var_7_2

			local var_7_3 = {}

			arg_7_0._illustrationShapeBoxCountDic[var_7_0] = var_7_3
		end

		if not arg_7_0._illustrationShapeDic[var_7_0][var_7_1] then
			local var_7_4 = {}
			local var_7_5 = 0
			local var_7_6 = string.split(iter_7_1.shape, "#")

			for iter_7_2 = 1, #var_7_6 do
				local var_7_7 = {}
				local var_7_8 = var_7_6[iter_7_2]
				local var_7_9 = string.splitToNumber(var_7_8, ",")

				for iter_7_3 = 1, #var_7_9 do
					var_7_7[iter_7_3] = var_7_9[iter_7_3]

					if var_7_9[iter_7_3] == 1 then
						var_7_5 = var_7_5 + 1
					end
				end

				var_7_4[iter_7_2] = var_7_7
			end

			arg_7_0._illustrationShapeDic[var_7_0][var_7_1] = var_7_4
			arg_7_0._illustrationShapeBoxCountDic[var_7_0][var_7_1] = var_7_5
		else
			logError(string.format("梁月角色活动 插图表id重复 actId:%s id:%s", var_7_0, var_7_1))
		end
	end
end

function var_0_0.getEpisodeStaticIllustrationDic(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._episodeStaticIllustrationDic[arg_8_1] then
		return arg_8_0._episodeStaticIllustrationDic[arg_8_1][arg_8_2]
	end

	return nil
end

function var_0_0.getIllustrationShape(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._illustrationShapeDic[arg_9_1] then
		return nil
	end

	return arg_9_0._illustrationShapeDic[arg_9_1][arg_9_2]
end

function var_0_0.getIllustrationShapeCount(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._illustrationShapeBoxCountDic[arg_10_1] then
		return nil
	end

	return arg_10_0._illustrationShapeBoxCountDic[arg_10_1][arg_10_2]
end

function var_0_0.getIllustrationAttribute(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getIllustrationConfigById(arg_11_1, arg_11_2)

	if var_11_0 == nil then
		return
	end

	if not arg_11_0._illustrationAttributeConfig then
		arg_11_0._illustrationAttributeConfig = {}
	end

	if not arg_11_0._illustrationAttributeConfig[arg_11_1] then
		arg_11_0._illustrationAttributeConfig[arg_11_1] = {}
	end

	if not arg_11_0._illustrationAttributeConfig[arg_11_1][arg_11_2] then
		local var_11_1 = {}
		local var_11_2 = string.split(var_11_0.attribute, "|")

		for iter_11_0, iter_11_1 in ipairs(var_11_2) do
			local var_11_3 = string.splitToNumber(iter_11_1, "#")
			local var_11_4 = var_11_3[1]
			local var_11_5 = var_11_3[2]
			local var_11_6 = var_11_3[3]

			var_11_1[var_11_4] = {
				var_11_4,
				var_11_5,
				var_11_6
			}
		end

		arg_11_0._illustrationAttributeConfig[arg_11_1][arg_11_2] = var_11_1

		return var_11_1
	end

	return arg_11_0._illustrationAttributeConfig[arg_11_1][arg_11_2]
end

function var_0_0.getEpisodeConfigByActAndId(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._episodeConfig.configDict[arg_12_1] then
		return nil
	end

	return arg_12_0._episodeConfig.configDict[arg_12_1][arg_12_2]
end

function var_0_0.getEpisodePuzzleConfigByActAndId(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._episodePuzzleConfig.configDict[arg_13_1] then
		return nil
	end

	return arg_13_0._episodePuzzleConfig.configDict[arg_13_1][arg_13_2]
end

function var_0_0.getIllustrationConfigById(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._illustrationConfig.configDict[arg_14_1] then
		return nil
	end

	return arg_14_0._illustrationConfig.configDict[arg_14_1][arg_14_2]
end

function var_0_0.getNoGameEpisodeList(arg_15_0, arg_15_1)
	if not arg_15_0._episodeConfig.configDict[arg_15_1] then
		return nil
	end

	if not arg_15_0._noGameEpisodeDic[arg_15_1] then
		local var_15_0 = {}
		local var_15_1 = arg_15_0._episodeConfig.configDict[arg_15_1]

		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			if iter_15_1.puzzleId == 0 then
				table.insert(var_15_0, iter_15_1)
			end
		end

		table.sort(var_15_0, arg_15_0._sortEpisode)

		arg_15_0._noGameEpisodeDic[arg_15_1] = var_15_0
	end

	return arg_15_0._noGameEpisodeDic[arg_15_1]
end

function var_0_0._sortEpisode(arg_16_0, arg_16_1)
	return arg_16_0.episodeId <= arg_16_1.episodeId
end

function var_0_0.getAfterGameEpisodeId(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._episodeConfig.configDict[arg_17_1] then
		return nil
	end

	if not arg_17_0._afterGameEpisodeDic[arg_17_1] then
		local var_17_0 = {}
		local var_17_1 = arg_17_0._episodeConfig.configDict[arg_17_1]

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			if iter_17_1.puzzleId ~= 0 then
				var_17_0[iter_17_1.preEpisodeId] = iter_17_1.episodeId
			end
		end

		arg_17_0._afterGameEpisodeDic[arg_17_1] = var_17_0
	end

	return arg_17_0._afterGameEpisodeDic[arg_17_1][arg_17_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
