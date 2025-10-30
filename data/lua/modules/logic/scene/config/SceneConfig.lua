module("modules.logic.scene.config.SceneConfig", package.seeall)

local var_0_0 = class("SceneConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._scene2LevelCOs = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"scene",
		"scene_level",
		"camera",
		"loading_text",
		"loading_icon",
		"scene_ctrl"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "loading_icon" then
		arg_3_0:_initLoadingIcon()
	elseif arg_3_1 == "loading_text" then
		arg_3_0:_initLoadingText()
	end
end

function var_0_0._initLoadingIcon(arg_4_0)
	arg_4_0._loadingIconList = {}

	for iter_4_0, iter_4_1 in ipairs(lua_loading_icon.configList) do
		if iter_4_1.isOnline == 1 then
			table.insert(arg_4_0._loadingIconList, iter_4_1)
		end
	end
end

function var_0_0._initLoadingText(arg_5_0)
	arg_5_0._loadingTextList = {}

	for iter_5_0, iter_5_1 in ipairs(lua_loading_text.configList) do
		if iter_5_1.isOnline == 1 then
			table.insert(arg_5_0._loadingTextList, iter_5_1)
		end
	end
end

function var_0_0.getSceneLevelCOs(arg_6_0, arg_6_1)
	if not arg_6_0._scene2LevelCOs then
		arg_6_0._scene2LevelCOs = {}
	end

	local var_6_0 = lua_scene.configDict[arg_6_1]

	if not var_6_0 then
		logError("scene config not exist: " .. tostring(arg_6_1))

		return
	end

	if not arg_6_0._scene2LevelCOs[arg_6_1] then
		arg_6_0._scene2LevelCOs[arg_6_1] = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0.levels) do
			local var_6_1 = lua_scene_level.configDict[iter_6_1]

			if var_6_1 then
				table.insert(arg_6_0._scene2LevelCOs[arg_6_1], var_6_1)
			else
				logError("scene level config not exist: " .. tostring(iter_6_1))
			end
		end
	end

	return arg_6_0._scene2LevelCOs[arg_6_1]
end

function var_0_0.getLoadingIcons(arg_7_0)
	return arg_7_0._loadingIconList
end

function var_0_0.getLoadingTexts(arg_8_0)
	return arg_8_0._loadingTextList
end

var_0_0.instance = var_0_0.New()

return var_0_0
