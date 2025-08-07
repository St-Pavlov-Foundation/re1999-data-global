module("modules.configs.excel2json.lua_activity205_enter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	times = 6,
	name = 2,
	id = 1,
	icon = 5,
	targetDesc = 4,
	desc = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	targetDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
