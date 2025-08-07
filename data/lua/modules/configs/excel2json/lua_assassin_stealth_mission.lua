module("modules.configs.excel2json.lua_assassin_stealth_mission", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tips = 7,
	type = 3,
	param = 4,
	refresh1 = 8,
	random = 10,
	trigger = 6,
	desc = 5,
	next_mission = 2,
	id = 1,
	refresh2 = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	tips = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
