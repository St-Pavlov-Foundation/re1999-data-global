module("modules.configs.excel2json.lua_survival_map_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectDesc = 6,
	name = 3,
	useScene = 5,
	type = 2,
	id = 1,
	hardLevel = 7,
	initDisaster = 8,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	effectDesc = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
