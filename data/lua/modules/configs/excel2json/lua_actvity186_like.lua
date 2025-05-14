module("modules.configs.excel2json.lua_actvity186_like", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nameen = 4,
	name = 3,
	basevalueornot = 6,
	type = 1,
	icon = 5,
	activityId = 2
}
local var_0_2 = {
	"type"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
