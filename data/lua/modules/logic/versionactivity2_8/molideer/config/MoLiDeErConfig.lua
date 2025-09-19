module("modules.logic.versionactivity2_8.molideer.config.MoLiDeErConfig", package.seeall)

local var_0_0 = class("MoLiDeErConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity194_const",
		"activity194_episode",
		"activity194_game",
		"activity194_event",
		"activity194_option",
		"activity194_option_result",
		"activity194_item",
		"activity194_team",
		"activity194_buff",
		"activity194_task",
		"activity194_progress_desc",
		"activity194_progress"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._taskDict = {}
	arg_2_0._eventGroupDic = {}
	arg_2_0._eventCostDic = {}
	arg_2_0._optionResultCostDic = {}
	arg_2_0._optionConditionDic = {}
	arg_2_0._optionCostDic = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity194_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "activity194_episode" then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == "activity194_game" then
		arg_3_0._gameConfig = arg_3_2
	elseif arg_3_1 == "activity194_event" then
		arg_3_0._eventConfig = arg_3_2

		arg_3_0:_initEventConfig()
	elseif arg_3_1 == "activity194_option" then
		arg_3_0._optionConfig = arg_3_2

		arg_3_0:_initOptionConfig()
	elseif arg_3_1 == "activity194_option_result" then
		arg_3_0._optionResultConfig = arg_3_2

		arg_3_0:_initOptionResultConfig()
	elseif arg_3_1 == "activity194_item" then
		arg_3_0._itemConfig = arg_3_2
	elseif arg_3_1 == "activity194_team" then
		arg_3_0._teamConfig = arg_3_2
	elseif arg_3_1 == "activity194_buff" then
		arg_3_0._buffConfig = arg_3_2
	elseif arg_3_1 == "activity194_task" then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == "activity194_progress" then
		arg_3_0._progressConfig = arg_3_2
	elseif arg_3_1 == "activity194_progress_desc" then
		arg_3_0._progressDescConfig = arg_3_2

		arg_3_0:_initProgressDescConfig()
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

function var_0_0.getEventConfigByGroupId(arg_5_0, arg_5_1)
	if arg_5_0._eventGroupDic == nil or arg_5_0._eventGroupDic[arg_5_1] == nil then
		logError("莫莉德尔角色活动 没有对应事件库数据 id:" .. arg_5_1)

		return nil
	end

	return arg_5_0._eventGroupDic[arg_5_1]
end

function var_0_0.getEpisodeConfig(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0:_get2PrimarykeyCo(arg_6_0._episodeConfig, arg_6_1, arg_6_2)
end

function var_0_0.getConstConfig(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0:_get2PrimarykeyCo(arg_7_0._constConfig, arg_7_1, arg_7_2)
end

function var_0_0.getGameConfig(arg_8_0, arg_8_1)
	if arg_8_0._gameConfig == nil or arg_8_0._gameConfig.configDict == nil then
		return nil
	end

	return arg_8_0._gameConfig.configDict[arg_8_1]
end

function var_0_0.getOptionConfig(arg_9_0, arg_9_1)
	if arg_9_0._optionConfig == nil or arg_9_0._optionConfig.configDict == nil then
		return nil
	end

	return arg_9_0._optionConfig.configDict[arg_9_1]
end

function var_0_0.getOptionResultConfig(arg_10_0, arg_10_1)
	if arg_10_0._optionResultConfig == nil or arg_10_0._optionResultConfig.configDict == nil then
		return nil
	end

	return arg_10_0._optionResultConfig.configDict[arg_10_1]
end

function var_0_0.getItemConfig(arg_11_0, arg_11_1)
	if arg_11_0._itemConfig == nil or arg_11_0._itemConfig.configDict == nil then
		return nil
	end

	return arg_11_0._itemConfig.configDict[arg_11_1]
end

function var_0_0.getTeamConfig(arg_12_0, arg_12_1)
	if arg_12_0._teamConfig == nil or arg_12_0._teamConfig.configDict == nil then
		return nil
	end

	return arg_12_0._teamConfig.configDict[arg_12_1]
end

function var_0_0.getEventConfig(arg_13_0, arg_13_1)
	if arg_13_0._eventConfig == nil or arg_13_0._eventConfig.configDict == nil then
		return nil
	end

	return arg_13_0._eventConfig.configDict[arg_13_1]
end

function var_0_0.getBuffConfig(arg_14_0, arg_14_1)
	if arg_14_0._buffConfig == nil or arg_14_0._buffConfig.configDict == nil then
		return nil
	end

	return arg_14_0._buffConfig.configDict[arg_14_1]
end

function var_0_0.getItemConfig(arg_15_0, arg_15_1)
	if arg_15_0._itemConfig == nil or arg_15_0._itemConfig.configDict == nil then
		return nil
	end

	return arg_15_0._itemConfig.configDict[arg_15_1]
end

function var_0_0.getProgressConfig(arg_16_0, arg_16_1)
	if arg_16_0._progressConfig == nil or arg_16_0._progressConfig.configDict == nil then
		return nil
	end

	return arg_16_0._progressConfig.configDict[arg_16_1]
end

function var_0_0.getProgressDescConfigById(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._progressDescDic == nil or arg_17_0._progressDescDic[arg_17_1] == nil then
		return nil
	end

	return arg_17_0._progressDescDic[arg_17_1][arg_17_2]
end

function var_0_0.getProgressDescConfig(arg_18_0, arg_18_1)
	if arg_18_0._progressDescConfig == nil or arg_18_0._progressDescConfig.configDict == nil then
		return nil
	end

	return arg_18_0._progressDescConfig.configDict[arg_18_1]
end

function var_0_0.getEpisodeDicById(arg_19_0, arg_19_1)
	return arg_19_0:_get2PrimarykeyDic(arg_19_0._episodeConfig, arg_19_1)
end

function var_0_0.getEpisodeListById(arg_20_0, arg_20_1)
	return arg_20_0:_findListByActId(arg_20_0._episodeConfig, arg_20_1)
end

function var_0_0._findListByActId(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 and arg_21_1.configList then
		local var_21_0 = {}

		for iter_21_0, iter_21_1 in ipairs(arg_21_1.configList) do
			if iter_21_1.activityId == arg_21_2 then
				table.insert(var_21_0, iter_21_1)
			end
		end

		return var_21_0
	end

	return nil
end

function var_0_0.getOptionResultCost(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._optionResultCostDic == nil or arg_22_0._optionResultCostDic[arg_22_1] == nil then
		return 0
	end

	return arg_22_0._optionResultCostDic[arg_22_1][arg_22_2] or 0
end

function var_0_0.getOptionCost(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._optionCostDic == nil or arg_23_0._optionCostDic[arg_23_1] == nil then
		return 0
	end

	return arg_23_0._optionCostDic[arg_23_1][arg_23_2] or 0
end

function var_0_0.getOptionCondition(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._optionConditionDic == nil or arg_24_0._optionConditionDic[arg_24_1] == nil then
		return nil
	end

	return arg_24_0._optionConditionDic[arg_24_1][arg_24_2]
end

function var_0_0._get2PrimarykeyCo(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_1 and arg_25_1.configDict then
		local var_25_0 = arg_25_1.configDict[arg_25_2]

		return var_25_0 and var_25_0[arg_25_3]
	end

	return nil
end

function var_0_0._get2PrimarykeyDic(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 and arg_26_1.configDict then
		local var_26_0 = arg_26_1.configDict[arg_26_2]

		return var_26_0 and var_26_0.configDict
	end

	return nil
end

function var_0_0._initEventConfig(arg_27_0)
	if arg_27_0._eventConfig then
		for iter_27_0, iter_27_1 in ipairs(arg_27_0._eventConfig.configList) do
			local var_27_0 = tonumber(iter_27_1.eventGroup)
			local var_27_1

			if arg_27_0._eventGroupDic[var_27_0] == nil then
				var_27_1 = {}
				arg_27_0._eventGroupDic[var_27_0] = var_27_1
			else
				var_27_1 = arg_27_0._eventGroupDic[var_27_0]
			end

			if var_27_1[iter_27_1.eventId] == nil then
				var_27_1[iter_27_1.eventId] = iter_27_1
			else
				logError("莫莉德尔角色活动 事件id重复" .. iter_27_1.eventId)
			end
		end
	end
end

function var_0_0._initOptionResultConfig(arg_28_0)
	if arg_28_0._optionResultConfig then
		local var_28_0 = arg_28_0._optionResultCostDic

		for iter_28_0, iter_28_1 in ipairs(arg_28_0._optionResultConfig.configList) do
			local var_28_1 = string.split(iter_28_1.effect, "|")

			if var_28_0[iter_28_1.resultId] == nil then
				local var_28_2 = {}

				for iter_28_2, iter_28_3 in ipairs(var_28_1) do
					local var_28_3 = string.splitToNumber(iter_28_3, "#")
					local var_28_4 = var_28_3[1]

					if var_28_4 == MoLiDeErEnum.OptionCostType.Execution then
						local var_28_5 = var_28_3[2]

						if var_28_2[var_28_4] == nil then
							var_28_2[var_28_4] = -var_28_5
						else
							logError("莫莉德尔角色活动 选项效果id重复 id:" .. iter_28_1.resultId .. "typeId:" .. var_28_4)
						end
					end
				end

				var_28_0[iter_28_1.resultId] = var_28_2
			else
				logError("莫莉德尔角色活动 选项结果id重复" .. iter_28_1.resultId)
			end
		end

		arg_28_0._optionResultCostDic = var_28_0
	end
end

function var_0_0._initOptionConfig(arg_29_0)
	if arg_29_0._optionConfig then
		local var_29_0 = arg_29_0._optionConditionDic
		local var_29_1 = arg_29_0._optionCostDic

		for iter_29_0, iter_29_1 in ipairs(arg_29_0._optionConfig.configList) do
			local var_29_2 = iter_29_1.optionId
			local var_29_3 = string.split(iter_29_1.optionRestriction, "|")

			if var_29_0[var_29_2] == nil then
				local var_29_4 = {}

				for iter_29_2, iter_29_3 in ipairs(var_29_3) do
					local var_29_5 = string.splitToNumber(iter_29_3, "#")
					local var_29_6 = {}
					local var_29_7 = var_29_5[1]

					if var_29_7 == MoLiDeErEnum.OptionConditionType.Team or var_29_7 == MoLiDeErEnum.OptionConditionType.Item and var_29_4[var_29_7] == nil then
						var_29_4[var_29_7] = var_29_6

						for iter_29_4 = 2, #var_29_5 do
							local var_29_8 = var_29_5[iter_29_4]

							var_29_6[var_29_8] = var_29_8
						end
					end
				end

				var_29_0[var_29_2] = var_29_4
			else
				logError("莫莉德尔角色活动 选项id重复" .. var_29_2)
			end

			if iter_29_1.effect ~= nil and not string.nilorempty(iter_29_1.effect) and var_29_1[var_29_2] == nil then
				local var_29_9 = string.split(iter_29_1.effect, "|")

				for iter_29_5, iter_29_6 in ipairs(var_29_9) do
					local var_29_10 = string.splitToNumber(iter_29_6, "#")
					local var_29_11 = var_29_10[1]

					if var_29_1[var_29_2] == nil then
						var_29_1[var_29_2] = {}
					end

					var_29_1[var_29_2][var_29_11] = var_29_10[2]
				end
			end
		end
	end
end

function var_0_0._initProgressDescConfig(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._progressDescConfig.configList) do
		local var_30_1 = string.splitToNumber(iter_30_1.condition, "#")

		if var_30_1[2] then
			local var_30_2 = var_30_1[1]
			local var_30_3 = var_30_1[2]
			local var_30_4

			if var_30_0[var_30_2] == nil then
				var_30_4 = {}
				var_30_0[var_30_2] = var_30_4
			else
				var_30_4 = var_30_0[var_30_2]
			end

			var_30_4[var_30_3] = iter_30_1
		else
			logError("莫莉德尔 角色活动 玩法目标提示文本 主键数据缺失" .. iter_30_1.condition)
		end
	end

	arg_30_0._progressDescDic = var_30_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
