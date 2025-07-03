module("modules.configs.excel2json.lua_eliminate_battle_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerPoint = 2,
	effect = 3,
	name = 6,
	icon = 8,
	id = 1,
	cover = 4,
	limit = 5,
	desc = 7
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
