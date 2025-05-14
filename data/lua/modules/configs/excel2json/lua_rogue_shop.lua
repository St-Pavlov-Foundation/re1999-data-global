module("modules.configs.excel2json.lua_rogue_shop", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 2,
	pos13 = 15,
	pos12 = 14,
	pos5 = 7,
	pos1 = 3,
	pos8 = 10,
	pos4 = 6,
	pos14 = 16,
	pos15 = 17,
	pos6 = 8,
	pos10 = 12,
	pos16 = 18,
	pos9 = 11,
	pos11 = 13,
	pos3 = 5,
	pos7 = 9,
	pos2 = 4,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
