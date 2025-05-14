module("modules.configs.excel2json.lua_challenge_condition", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	decs1 = 4,
	decs2 = 6,
	id = 1,
	type = 2,
	value = 3,
	rule = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	decs2 = 2,
	decs1 = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
