module("modules.logic.scene.config.SceneConfig", package.seeall)

local var_0_0 = class("SceneConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._scene2LevelCOs = nil
	arg_1_0._iconCos = {}
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
		arg_3_0._iconCos = arg_3_2
	end
end

function var_0_0.getSceneLevelCOs(arg_4_0, arg_4_1)
	if not arg_4_0._scene2LevelCOs then
		arg_4_0._scene2LevelCOs = {}
	end

	local var_4_0 = lua_scene.configDict[arg_4_1]

	if not var_4_0 then
		logError("scene config not exist: " .. tostring(arg_4_1))

		return
	end

	if not arg_4_0._scene2LevelCOs[arg_4_1] then
		arg_4_0._scene2LevelCOs[arg_4_1] = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0.levels) do
			local var_4_1 = lua_scene_level.configDict[iter_4_1]

			if var_4_1 then
				table.insert(arg_4_0._scene2LevelCOs[arg_4_1], var_4_1)
			else
				logError("scene level config not exist: " .. tostring(iter_4_1))
			end
		end
	end

	return arg_4_0._scene2LevelCOs[arg_4_1]
end

function var_0_0.getLoadingIcons(arg_5_0)
	return arg_5_0._iconCos.configDict
end

var_0_0.instance = var_0_0.New()

return var_0_0
