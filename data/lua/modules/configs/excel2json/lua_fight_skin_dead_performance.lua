module("modules.configs.excel2json.lua_fight_skin_dead_performance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	actType5 = 10,
	actType1 = 2,
	actParam8 = 17,
	actParam5 = 11,
	actType2 = 4,
	actParam1 = 3,
	actType3 = 6,
	actType6 = 12,
	actParam6 = 13,
	actType4 = 8,
	actType7 = 14,
	actParam7 = 15,
	actParam2 = 5,
	actType8 = 16,
	actParam4 = 9,
	actParam3 = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
