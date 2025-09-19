module("modules.configs.excel2json.lua_survival_equip", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 3,
	effect = 8,
	group = 2,
	desc = 6,
	effectDesc = 4,
	tag = 7,
	id = 1,
	effectDesc2 = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	effectDesc = 1,
	desc = 3,
	effectDesc2 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
