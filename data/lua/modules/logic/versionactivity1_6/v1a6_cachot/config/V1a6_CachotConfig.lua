module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotConfig", package.seeall)

local var_0_0 = class("V1a6_CachotConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rogue_const",
		"rogue_difficulty",
		"rogue_room",
		"rogue_field",
		"rogue_heartbeat",
		"rogue_score",
		"rogue_scene_level"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rogue_score" then
		V1a6_CachotScoreConfig.instance:init(arg_3_2)
	elseif arg_3_1 == "rogue_room" then
		V1a6_CachotRoomConfig.instance:init(arg_3_2)
	end
end

function var_0_0.getHeartConfig(arg_4_0, arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in pairs(lua_rogue_heartbeat.configList) do
		local var_4_1 = string.splitToNumber(iter_4_1.range, "#")

		if arg_4_1 >= var_4_1[1] and arg_4_1 <= var_4_1[2] then
			var_4_0 = iter_4_1

			break
		end
	end

	if not var_4_0 then
		logError("没有心跳对应的配置:" .. arg_4_1)

		var_4_0 = lua_rogue_heartbeat.configList[1]
	end

	return var_4_0
end

function var_0_0.getDifficultyConfig(arg_5_0, arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(lua_rogue_difficulty.configList) do
		if arg_5_1 == iter_5_0 then
			var_5_0 = iter_5_1

			break
		end
	end

	if not var_5_0 then
		logError("没有难度对应的配置:" .. arg_5_1)

		var_5_0 = lua_rogue_difficulty.configList[1]
	end

	return var_5_0
end

function var_0_0.getDifficultyCount(arg_6_0)
	return #lua_rogue_difficulty.configList
end

function var_0_0.getConstConfig(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(lua_rogue_const.configList) do
		if arg_7_1 == iter_7_0 then
			var_7_0 = iter_7_1

			break
		end
	end

	if not var_7_0 then
		logError("没有常量对应的配置:" .. arg_7_1)

		var_7_0 = lua_rogue_const.configList[1]
	end

	return var_7_0
end

function var_0_0.getSceneLevelId(arg_8_0, arg_8_1)
	return (lua_rogue_scene_level.configDict[arg_8_1] or lua_rogue_scene_level.configList[1]).sceneLevel
end

var_0_0.instance = var_0_0.New()

return var_0_0
