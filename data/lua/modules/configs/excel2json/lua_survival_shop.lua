module("modules.configs.excel2json.lua_survival_shop", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	pos12 = 15,
	pos13 = 16,
	pos8 = 11,
	pos5 = 8,
	pos19 = 22,
	name = 2,
	pos4 = 7,
	pos14 = 17,
	type = 3,
	pos15 = 18,
	pos17 = 20,
	pos1 = 4,
	pos20 = 23,
	pos6 = 9,
	pos21 = 24,
	pos10 = 13,
	pos22 = 25,
	pos16 = 19,
	pos9 = 12,
	pos11 = 14,
	pos3 = 6,
	pos7 = 10,
	pos2 = 5,
	id = 1,
	pos18 = 21
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
