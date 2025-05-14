module("modules.configs.excel2json.lua_stance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	pos8 = 9,
	pos1 = 2,
	subPos1 = 10,
	pos5 = 6,
	subPos2 = 11,
	subPos3 = 12,
	pos4 = 5,
	dec_stance = 13,
	pos3 = 4,
	cardCamera = 14,
	pos7 = 8,
	pos2 = 3,
	id = 1,
	pos6 = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
