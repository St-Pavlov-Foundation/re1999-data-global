module("modules.configs.excel2json.lua_stress_identity", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 6,
	name = 2,
	effect = 5,
	id = 1,
	typeParam = 4,
	isNoShow = 7,
	desc = 8,
	identity = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
