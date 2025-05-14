module("modules.configs.excel2json.lua_fight_next_round_get_card", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	exclusion = 5,
	priority = 2,
	tempCard = 6,
	skillId = 4,
	id = 1,
	condition = 3
}
local var_0_2 = {
	"id",
	"priority"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
