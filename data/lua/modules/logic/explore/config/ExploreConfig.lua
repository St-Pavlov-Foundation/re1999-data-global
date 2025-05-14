module("modules.logic.explore.config.ExploreConfig", package.seeall)

local var_0_0 = class("ExploreConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"explore_scene",
		"explore_dialogue",
		"explore_item",
		"explore_item_type",
		"explore_unit",
		"explore_unit_effect",
		"explore_hero_effect",
		"task_explore",
		"explore_story",
		"explore_chest",
		"explore_bubble",
		"explore_signs"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._chapterToMapIds = {}
	arg_2_0._taskCos = {}
	arg_2_0._rewardCos = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "explore_scene" then
		arg_3_0.sceneConfig = arg_3_2
		arg_3_0.mapIdConfig = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.sceneConfig.configList) do
			arg_3_0.mapIdConfig[iter_3_1.id] = iter_3_1

			if not arg_3_0._chapterToMapIds[iter_3_1.chapterId] then
				arg_3_0._chapterToMapIds[iter_3_1.chapterId] = {}
			end

			table.insert(arg_3_0._chapterToMapIds[iter_3_1.chapterId], iter_3_1.id)
		end
	elseif arg_3_1 == "explore_item" then
		arg_3_0.itemConfig = arg_3_2
	elseif arg_3_1 == "explore_item_type" then
		arg_3_0.itemTypeConfig = arg_3_2
	elseif arg_3_1 == "explore_unit" then
		arg_3_0.unitConfig = arg_3_2
	elseif arg_3_1 == "explore_dialogue" then
		arg_3_0.dialogueConfig = arg_3_2
	elseif arg_3_1 == "explore_unit_effect" then
		arg_3_0.unitEffectConfig = arg_3_2
	elseif arg_3_1 == "task_explore" then
		arg_3_0:_buildTaskConfig()
	elseif arg_3_1 == "explore_chest" then
		arg_3_0:_buildRewardConfig()
	end
end

function var_0_0.loadExploreConfig(arg_4_0, arg_4_1)
	arg_4_0._mapConfig = addGlobalModule("modules.configs.explore.lua_explore_map_" .. tostring(arg_4_1), "lua_explore_map_" .. tostring(arg_4_1))
end

local function var_0_1(arg_5_0, arg_5_1)
	return arg_5_0.maxProgress < arg_5_1.maxProgress
end

local function var_0_2(arg_6_0, arg_6_1)
	return arg_6_0.id < arg_6_1.id
end

function var_0_0._buildRewardConfig(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(lua_explore_chest.configList) do
		arg_7_0._rewardCos[iter_7_1.chapterId] = arg_7_0._rewardCos[iter_7_1.chapterId] or {}
		arg_7_0._rewardCos[iter_7_1.chapterId][iter_7_1.episodeId] = arg_7_0._rewardCos[iter_7_1.chapterId][iter_7_1.episodeId] or {}

		if iter_7_1.isCount == 1 then
			table.insert(arg_7_0._rewardCos[iter_7_1.chapterId][iter_7_1.episodeId], iter_7_1)
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._rewardCos) do
		for iter_7_4, iter_7_5 in pairs(iter_7_3) do
			table.sort(iter_7_5, var_0_2)
		end
	end
end

function var_0_0.getRewardConfig(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._rewardCos[arg_8_1] then
		return {}
	end

	return arg_8_0._rewardCos[arg_8_1][arg_8_2] or {}
end

function var_0_0._buildTaskConfig(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(lua_task_explore.configList) do
		local var_9_0 = string.splitToNumber(iter_9_1.listenerParam, "#")

		if not arg_9_0._taskCos[var_9_0[1]] then
			arg_9_0._taskCos[var_9_0[1]] = {}
		end

		if not arg_9_0._taskCos[var_9_0[1]][var_9_0[2]] then
			arg_9_0._taskCos[var_9_0[1]][var_9_0[2]] = {}
		end

		table.insert(arg_9_0._taskCos[var_9_0[1]][var_9_0[2]], iter_9_1)
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._taskCos) do
		for iter_9_4, iter_9_5 in pairs(iter_9_3) do
			table.sort(iter_9_5, var_0_1)
		end
	end
end

function var_0_0.getTaskList(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._taskCos[arg_10_1] or not arg_10_0._taskCos[arg_10_1][arg_10_2] then
		return {}
	end

	return arg_10_0._taskCos[arg_10_1][arg_10_2]
end

function var_0_0.getMapConfig(arg_11_0)
	return arg_11_0._mapConfig
end

function var_0_0.getSceneId(arg_12_0, arg_12_1)
	return arg_12_0.mapIdConfig[arg_12_1].sceneId
end

function var_0_0.getMapIdsByChapter(arg_13_0, arg_13_1)
	return arg_13_0._chapterToMapIds[arg_13_1] or {}
end

function var_0_0.getAnimLength(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = lua_explore_anim_length[arg_14_1]

	if not var_14_0 then
		return
	end

	return var_14_0[arg_14_2]
end

function var_0_0.getMapIdConfig(arg_15_0, arg_15_1)
	return arg_15_0.mapIdConfig[arg_15_1]
end

function var_0_0.getEpisodeId(arg_16_0, arg_16_1)
	return arg_16_0.mapIdConfig[arg_16_1].episodeId
end

function var_0_0.getDialogueConfig(arg_17_0, arg_17_1)
	return arg_17_0.dialogueConfig.configDict[arg_17_1]
end

function var_0_0.getItemCo(arg_18_0, arg_18_1)
	return arg_18_0.itemConfig.configDict[arg_18_1]
end

function var_0_0.isStackableItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.itemConfig.configDict[arg_19_1]

	return var_19_0 and var_19_0.isClientStackable or false
end

function var_0_0.isActiveTypeItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.itemTypeConfig.configDict[arg_20_1]

	return var_20_0 and var_20_0.isActiveType or false
end

function var_0_0.getUnitName(arg_21_0, arg_21_1)
	if arg_21_0.unitConfig.configDict[arg_21_1] then
		return arg_21_0.unitConfig.configDict[arg_21_1].name
	end

	return arg_21_1
end

function var_0_0.getUnitNeedShowName(arg_22_0, arg_22_1)
	if arg_22_0.unitConfig.configDict[arg_22_1] then
		return arg_22_0.unitConfig.configDict[arg_22_1].isShow
	end

	return false
end

function var_0_0.getUnitEffectConfig(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 then
		return
	end

	local var_23_0 = string.match(arg_23_1, "/([0-9a-zA-Z_]+)%.prefab$")
	local var_23_1 = arg_23_0.unitEffectConfig.configDict[var_23_0]

	if var_23_1 and var_23_1[arg_23_2] then
		return var_23_1[arg_23_2].effectPath, var_23_1[arg_23_2].isOnce == 1, var_23_1[arg_23_2].audioId, var_23_1[arg_23_2].isBindGo == 1, var_23_1[arg_23_2].isLoopAudio == 1
	end
end

function var_0_0.getAssetNeedAkGo(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return false
	end

	arg_24_0._pathNeedAkDict = arg_24_0._pathNeedAkDict or {}

	if arg_24_0._pathNeedAkDict[arg_24_1] ~= nil then
		return arg_24_0._pathNeedAkDict[arg_24_1]
	end

	local var_24_0 = false
	local var_24_1 = string.match(arg_24_1, "/([0-9a-zA-Z_]+)%.prefab$")
	local var_24_2 = arg_24_0.unitEffectConfig.configDict[var_24_1]

	if var_24_2 then
		for iter_24_0, iter_24_1 in pairs(var_24_2) do
			if iter_24_1.isBindGo then
				var_24_0 = true

				break
			end
		end
	end

	arg_24_0._pathNeedAkDict[arg_24_1] = var_24_0

	return var_24_0
end

function var_0_0.getArchiveTotalCount(arg_25_0, arg_25_1)
	if not arg_25_0._archiveCountDict then
		arg_25_0._archiveCountDict = {}

		for iter_25_0, iter_25_1 in pairs(lua_explore_story.configDict) do
			arg_25_0._archiveCountDict[iter_25_0] = tabletool.len(iter_25_1)
		end
	end

	return arg_25_0._archiveCountDict[arg_25_1] or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
