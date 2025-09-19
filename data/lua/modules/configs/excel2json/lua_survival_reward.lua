module("modules.configs.excel2json.lua_survival_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local var_0_2 = {
	"id",
	"score"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
