module("modules.configs.excel2json.lua_survival_booster", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	name = 2,
	tag = 6,
	effectDesc = 3,
	icon = 5,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	effectDesc = 2,
	name = 1,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
