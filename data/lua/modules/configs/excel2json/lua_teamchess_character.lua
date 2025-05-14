module("modules.configs.excel2json.lua_teamchess_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activeSkillIds = 8,
	name = 2,
	id = 1,
	specialAttr1 = 10,
	specialAttr2 = 11,
	initPower = 4,
	passiveSkillIds = 9,
	specialAttr3 = 12,
	specialAttr4 = 13,
	hp = 3,
	resPic = 7,
	maxPowerLimit = 6,
	initDiamonds = 5,
	specialAttr5 = 14
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
