module("modules.logic.versionactivity2_7.lengzhou6.config.LengZhou6EliminateConfig", package.seeall)

local var_0_0 = class("LengZhou6EliminateConfig", EliminateConfig)

function var_0_0._initEliminateChessConfig(arg_1_0)
	var_0_0.super._initEliminateChessConfig(arg_1_0)

	arg_1_0._eliminateLevelConfig = {}

	for iter_1_0 = 1, #T_lua_eliminate_level do
		local var_1_0 = T_lua_eliminate_level[iter_1_0]

		arg_1_0._eliminateLevelConfig[var_1_0.id] = var_1_0
	end
end

function var_0_0.getEliminateChessLevelConfig(arg_2_0, arg_2_1)
	if arg_2_0._eliminateLevelConfig == nil then
		arg_2_0:_initEliminateChessConfig()
	end

	return arg_2_0._eliminateLevelConfig[arg_2_1] and arg_2_0._eliminateLevelConfig[arg_2_1].chess or ""
end

var_0_0.instance = var_0_0.New()

return var_0_0
