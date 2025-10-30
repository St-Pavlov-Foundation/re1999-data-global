module("modules.configs.excel2json.lua_activity203_ai", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	gaptime = 3,
	assist_weight = 10,
	negative_move_weight = 8,
	attack_weight = 4,
	positive_move_weight = 6,
	hero_move_rate = 11,
	hero_go_front_ornot = 13,
	ai_index = 2,
	negative_move_trigger_rate = 9,
	attack_trigger_rate = 5,
	positive_move_trigger_rate = 7,
	id = 1,
	hero_or_soldier = 12
}
local var_0_2 = {
	"id",
	"ai_index"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
