module("modules.configs.excel2json.lua_activity194_team", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	teamId = 1,
	name = 4,
	buffId = 2,
	roundActionTime = 5,
	iconOffset = 6,
	picture = 3
}
local var_0_2 = {
	"teamId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
