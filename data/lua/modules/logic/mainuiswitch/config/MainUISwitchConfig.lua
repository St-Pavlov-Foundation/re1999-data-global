module("modules.logic.mainuiswitch.config.MainUISwitchConfig", package.seeall)

local var_0_0 = class("MainUISwitchConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"scene_ui",
		"scene_ui_reddot",
		"main_ui_skin",
		"main_ui_eagle"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "scene_ui" then
		arg_3_0:_initUISwitchConfig()
	elseif arg_3_1 == "scene_ui_reddot" then
		arg_3_0._uiReddotCo = arg_3_2
	elseif arg_3_1 == "main_ui_skin" then
		arg_3_0._skinConfig = arg_3_2

		arg_3_0:_initMainUISkinCo()
	elseif arg_3_1 == "main_ui_eagle" then
		arg_3_0._eagleAnimConfig = arg_3_2
	end
end

function var_0_0._initUISwitchConfig(arg_4_0)
	arg_4_0.uiItem = {}
	arg_4_0._itemSource = {}

	for iter_4_0, iter_4_1 in ipairs(lua_scene_ui.configList) do
		arg_4_0.uiItem[iter_4_1.itemId] = iter_4_1
	end
end

function var_0_0.getUISwitchCoByItemId(arg_5_0, arg_5_1)
	return arg_5_0.uiItem[arg_5_1]
end

function var_0_0.getUIReddotStyle(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._uiReddotCo.configDict[arg_6_1]

	return var_6_0 and var_6_0[arg_6_2]
end

function var_0_0._initMainUISkinCo(arg_7_0)
	arg_7_0._mainUiCos = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._skinConfig.configList) do
		if not arg_7_0._mainUiCos[iter_7_1.skinId] then
			arg_7_0._mainUiCos[iter_7_1.skinId] = {}
		end

		arg_7_0._mainUiCos[iter_7_1.skinId][iter_7_1.id] = iter_7_1
	end
end

function var_0_0.getMainUISkinCosbySkinId(arg_8_0, arg_8_1)
	return arg_8_0._mainUiCos[arg_8_1]
end

function var_0_0.getMainUISkinCo(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._skinConfig.configDict[arg_9_1] then
		return
	end

	return arg_9_0._skinConfig.configDict[arg_9_1][arg_9_2]
end

function var_0_0.getEagleAnim(arg_10_0, arg_10_1)
	return arg_10_0._eagleAnimConfig.configDict[arg_10_1]
end

function var_0_0.getItemSource(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._itemSource[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:_collectSource(arg_11_1)
		arg_11_0._itemSource[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0._collectSource(arg_12_0, arg_12_1)
	local var_12_0 = lua_item.configDict[arg_12_1].sources
	local var_12_1 = {}

	if not string.nilorempty(var_12_0) then
		local var_12_2 = string.split(var_12_0, "|")

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			local var_12_3 = string.splitToNumber(iter_12_1, "#")
			local var_12_4 = {
				sourceId = var_12_3[1],
				probability = var_12_3[2]
			}

			var_12_4.episodeId = JumpConfig.instance:getJumpEpisodeId(var_12_4.sourceId)

			if var_12_4.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_12_4.episodeId) then
				table.insert(var_12_1, var_12_4)
			end
		end
	end

	return var_12_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
