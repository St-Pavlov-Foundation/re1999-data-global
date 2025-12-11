module("modules.logic.clickuiswitch.config.ClickUISwitchConfig", package.seeall)

local var_0_0 = class("ClickUISwitchConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"scene_click"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "scene_click" then
		arg_3_0:_initClickUIConfig()
	end
end

function var_0_0._initClickUIConfig(arg_4_0)
	arg_4_0.uiItem = {}
	arg_4_0._itemSource = {}

	for iter_4_0, iter_4_1 in ipairs(lua_scene_click.configList) do
		arg_4_0.uiItem[iter_4_1.itemId] = iter_4_1
	end

	ClickUISwitchModel.instance:initConfig()
end

function var_0_0.getClickUICoByItemId(arg_5_0, arg_5_1)
	return arg_5_0.uiItem[arg_5_1]
end

function var_0_0.getItemSource(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._itemSource[arg_6_1]

	if not var_6_0 then
		var_6_0 = arg_6_0:_collectSource(arg_6_1)
		arg_6_0._itemSource[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0._collectSource(arg_7_0, arg_7_1)
	local var_7_0 = lua_item.configDict[arg_7_1].sources
	local var_7_1 = {}

	if not string.nilorempty(var_7_0) then
		local var_7_2 = string.split(var_7_0, "|")

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			local var_7_3 = string.splitToNumber(iter_7_1, "#")
			local var_7_4 = {
				sourceId = var_7_3[1],
				probability = var_7_3[2]
			}

			var_7_4.episodeId = JumpConfig.instance:getJumpEpisodeId(var_7_4.sourceId)

			if var_7_4.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_7_4.episodeId) then
				table.insert(var_7_1, var_7_4)
			end
		end
	end

	return var_7_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
