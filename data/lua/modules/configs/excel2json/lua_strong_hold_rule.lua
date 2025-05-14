module("modules.configs.excel2json.lua_strong_hold_rule", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skillIds = 6,
	id = 1,
	fixValue = 4,
	desc = 2,
	prohibitSkillTags = 5,
	fixType = 3,
	addSkillIds = 7,
	effectIds = 8,
	putLimit = 9,
	startEffectRound = 10,
	endEffectRound = 11
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
