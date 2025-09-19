module("modules.configs.excel2json.lua_survival_copy", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	effect = 7,
	useScene = 6,
	abPath = 5,
	name = 2,
	desc = 4,
	pic = 10,
	enName = 3,
	mapGroup = 9,
	lightPram = 11,
	effectDesc = 8
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
