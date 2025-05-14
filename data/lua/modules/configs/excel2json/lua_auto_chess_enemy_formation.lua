module("modules.configs.excel2json.lua_auto_chess_enemy_formation", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	index5 = 9,
	index3 = 7,
	zoneId = 4,
	index1Buff = 10,
	index3Buff = 12,
	index4 = 8,
	round = 3,
	index2Buff = 11,
	index4Buff = 13,
	index2 = 6,
	index5Buff = 14,
	enemyId = 2,
	id = 1,
	index1 = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
