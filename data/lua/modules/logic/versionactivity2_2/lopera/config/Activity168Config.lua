module("modules.logic.versionactivity2_2.lopera.config.Activity168Config", package.seeall)

local var_0_0 = class("Activity168Config", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._episodeConfig = nil
	arg_1_0._eventConfig = nil
	arg_1_0._optionConfig = nil
	arg_1_0._effectConfig = nil
	arg_1_0._itemConfig = nil
	arg_1_0._taskCfg = nil
	arg_1_0._composeTypeCfg = nil
	arg_1_0._composeItemCfg = nil
	arg_1_0._constCfg = nil
	arg_1_0._endlessCfg = nil
	arg_1_0._episodeDict = {}
	arg_1_0._mapCfgField = {
		id = 1,
		name = 3,
		coord = 2,
		isStart = 6,
		dir = 4,
		event = 5,
		isEnd = 7
	}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity168_episode",
		"activity168_event",
		"activity168_option",
		"activity168_effect",
		"activity168_item",
		"activity168_compose_type",
		"activity168_task",
		"activity168_const",
		"activity168_endless_event"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity168_episode" then
		arg_3_0._episodeConfig = arg_3_2
		arg_3_0._episodeDict = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0._episodeConfig.configList) do
			arg_3_0._episodeDict[iter_3_1.activityId] = arg_3_0._episodeDict[iter_3_1.activityId] or {}

			table.insert(arg_3_0._episodeDict[iter_3_1.activityId], iter_3_1)
		end
	elseif arg_3_1 == "activity168_event" then
		arg_3_0._eventConfig = arg_3_2
	elseif arg_3_1 == "activity168_option" then
		arg_3_0._optionConfig = arg_3_2
	elseif arg_3_1 == "activity168_effect" then
		arg_3_0._effectConfig = arg_3_2
	elseif arg_3_1 == "activity168_item" then
		arg_3_0._itemConfig = arg_3_2
	elseif arg_3_1 == "activity168_task" then
		arg_3_0._taskCfg = arg_3_2
	elseif arg_3_1 == "activity168_compose_type" then
		arg_3_0._composeTypeCfg = arg_3_2
	elseif arg_3_1 == "activity168_const" then
		arg_3_0._constCfg = arg_3_2
	elseif arg_3_1 == "activity168_endless_event" then
		arg_3_0._endlessCfg = arg_3_2
	end
end

function var_0_0.getEpisodeCfgList(arg_4_0, arg_4_1)
	return arg_4_0._episodeDict[arg_4_1] or {}
end

function var_0_0.getEpisodeCfg(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._episodeDict[arg_5_1]

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.id == arg_5_2 then
			return iter_5_1
		end
	end
end

function var_0_0.getEventCfg(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._eventConfig.configDict[arg_6_1]

	return var_6_0 and var_6_0[arg_6_2]
end

function var_0_0.getEventOptionCfg(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._optionConfig.configDict[arg_7_1]

	return var_7_0 and var_7_0[arg_7_2]
end

function var_0_0.getOptionEffectCfg(arg_8_0, arg_8_1)
	return arg_8_0._effectConfig.configDict[arg_8_1]
end

function var_0_0.getGameItemCfg(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._itemConfig.configDict[arg_9_1]

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1.itemId == arg_9_2 then
			return iter_9_1
		end
	end
end

function var_0_0.getGameItemListCfg(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = arg_10_0._itemConfig.configDict[arg_10_1]

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		if arg_10_2 == nil or iter_10_1.compostType == arg_10_2 then
			var_10_0[#var_10_0 + 1] = iter_10_1
		end
	end

	return var_10_0
end

function var_0_0.InitMapCfg(arg_11_0, arg_11_1)
	arg_11_0._mapId = arg_11_1
	arg_11_0._mapCfg = addGlobalModule("modules.configs.act168.lua_act168_map_" .. tostring(arg_11_1), "lua_act168_map_" .. tostring(arg_11_1))
	arg_11_0._mapRowNum = 0
	arg_11_0._mapCalNum = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._mapCfg) do
		local var_11_0 = iter_11_1[arg_11_0._mapCfgField.coord]

		arg_11_0._mapRowNum = math.max(arg_11_0._mapRowNum, var_11_0[2])
		arg_11_0._mapCalNum = math.max(arg_11_0._mapCalNum, var_11_0[1])
	end

	arg_11_0._mapRowNum = arg_11_0._mapRowNum + 1
	arg_11_0._mapCalNum = arg_11_0._mapCalNum + 1
end

function var_0_0.getMapCfg(arg_12_0, arg_12_1)
	if not arg_12_0._mapCfg or arg_12_0._mapId ~= arg_12_1 then
		arg_12_0:InitMapCfg(arg_12_1)
	end

	return arg_12_0._mapCfg
end

function var_0_0.getMapStartCell(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._mapCfg) do
		if iter_13_1[arg_13_0._mapCfgField.isStart] then
			return iter_13_1
		end
	end
end

function var_0_0.getMapEndCell(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._mapCfg) do
		if iter_14_1[arg_14_0._mapCfgField.isEnd] then
			return iter_14_1
		end
	end
end

function var_0_0.getMapCell(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._mapCfg) do
		if iter_15_1[arg_15_0._mapCfgField.id] == arg_15_1 then
			return iter_15_1
		end
	end
end

function var_0_0.getMapCellByCoord(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1[1] + arg_16_0._mapCalNum * arg_16_1[2] + 1

	return arg_16_0._mapCfg[var_16_0]
end

function var_0_0.getTaskList(arg_17_0, arg_17_1)
	if arg_17_0._task_list then
		return arg_17_0._task_list
	end

	arg_17_0._task_list = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0._taskCfg.configDict) do
		if arg_17_1 == iter_17_1.activityId then
			arg_17_0._task_list[#arg_17_0._task_list + 1] = iter_17_1
		end
	end

	return arg_17_0._task_list
end

function var_0_0.getComposeTypeList(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._composeTypeCfg.configList) do
		if arg_18_1 == iter_18_1.activityId then
			var_18_0[#var_18_0 + 1] = iter_18_1
		end
	end

	return var_18_0
end

function var_0_0.getComposeTypeCfg(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._composeTypeCfg.configList) do
		if arg_19_1 == iter_19_1.activityId and arg_19_2 == iter_19_1.composeType then
			return iter_19_1
		end
	end
end

function var_0_0.getConstCfg(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._constCfg.configDict[arg_20_1]

	if not var_20_0 then
		return
	end

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if arg_20_2 == iter_20_1.id then
			return iter_20_1
		end
	end
end

function var_0_0.getConstValueCfg(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._constCfg.configDict[arg_21_1]

	if not var_21_0 then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if arg_21_2 == iter_21_1.value1 then
			return iter_21_1
		end
	end
end

function var_0_0.getEndlessLevelCfg(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._endlessCfg.configDict[arg_22_1]

	if not var_22_0 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if arg_22_2 == iter_22_1.id then
			return iter_22_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
