module("modules.configs.excel2json.lua_eliminate_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 5,
	star = 4,
	bonus = 6,
	id = 1,
	activityId = 2,
	desc = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
