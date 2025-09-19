module("modules.configs.excel2json.lua_survival_equip_found", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon2 = 6,
	name = 5,
	desc1 = 3,
	value = 8,
	desc = 2,
	icon4 = 9,
	icon3 = 7,
	id = 1,
	icon = 4,
	level = 10
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc1 = 2,
	name = 3,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
