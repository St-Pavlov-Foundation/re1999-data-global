module("modules.logic.mainsceneswitch.config.MainSceneSwitchConfig", package.seeall)

local var_0_0 = class("MainSceneSwitchConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"scene_switch",
		"scene_settings",
		"scene_effect_settings"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "scene_switch" then
		arg_3_0:_initSceneSwitchConfig()
	end
end

function var_0_0._initSceneSwitchConfig(arg_4_0)
	arg_4_0._itemMap = {}
	arg_4_0._itemLockList = {}
	arg_4_0._itemSource = {}
	arg_4_0._defaultSceneId = nil

	for iter_4_0, iter_4_1 in ipairs(lua_scene_switch.configList) do
		arg_4_0._itemMap[iter_4_1.itemId] = iter_4_1

		if iter_4_1.defaultUnlock == 1 then
			if arg_4_0._defaultSceneId ~= nil then
				logError("MainSceneSwitchConfig:_initSceneSwitchConfig has more than one default scene")
			end

			arg_4_0._defaultSceneId = iter_4_1.id
		else
			table.insert(arg_4_0._itemLockList, iter_4_1.itemId)
		end
	end

	if not arg_4_0._defaultSceneId then
		logError("MainSceneSwitchConfig:_initSceneSwitchConfig has no default scene")
	end
end

function var_0_0.getItemSource(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._itemSource[arg_5_1]

	if not var_5_0 then
		var_5_0 = arg_5_0:_collectSource(arg_5_1)
		arg_5_0._itemSource[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0._collectSource(arg_6_0, arg_6_1)
	local var_6_0 = lua_item.configDict[arg_6_1].sources
	local var_6_1 = {}

	if not string.nilorempty(var_6_0) then
		local var_6_2 = string.split(var_6_0, "|")

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			local var_6_3 = string.splitToNumber(iter_6_1, "#")
			local var_6_4 = {
				sourceId = var_6_3[1],
				probability = var_6_3[2]
			}

			var_6_4.episodeId = JumpConfig.instance:getJumpEpisodeId(var_6_4.sourceId)

			if var_6_4.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_6_4.episodeId) then
				table.insert(var_6_1, var_6_4)
			end
		end
	end

	return var_6_1
end

function var_0_0.getItemLockList(arg_7_0)
	return arg_7_0._itemLockList
end

function var_0_0.getConfigByItemId(arg_8_0, arg_8_1)
	return arg_8_0._itemMap[arg_8_1]
end

function var_0_0.getDefaultSceneId(arg_9_0)
	return arg_9_0._defaultSceneId
end

function var_0_0.getSceneEffect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = lua_scene_effect_settings.configDict[arg_10_1]

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if iter_10_1.tag == arg_10_2 then
				return iter_10_1
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
