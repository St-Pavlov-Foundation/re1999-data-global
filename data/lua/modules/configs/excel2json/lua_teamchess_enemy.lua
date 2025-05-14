module("modules.configs.excel2json.lua_teamchess_enemy", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 2,
	passiveSkillIds = 7,
	specialAttr1 = 9,
	behaviorId = 8,
	specialAttr2 = 10,
	headImg = 4,
	specialAttr3 = 11,
	specialAttr5 = 13,
	specialAttr4 = 12,
	hp = 3,
	id = 1,
	skillIcon = 5,
	skillDesc = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	skillDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
