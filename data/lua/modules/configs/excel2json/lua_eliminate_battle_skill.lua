module("modules.configs.excel2json.lua_eliminate_battle_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerPoint = 7,
	name = 2,
	cd = 6,
	type = 4,
	effect = 9,
	condition = 8,
	desc = 3,
	id = 1,
	icon = 5
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
