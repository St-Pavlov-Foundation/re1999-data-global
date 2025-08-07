module("modules.configs.excel2json.lua_assassin_career_skill_mapping", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	targetCheck = 11,
	name = 4,
	prerequisite = 14,
	type = 8,
	addSkill = 7,
	targetEff = 13,
	id = 1,
	desc = 6,
	range = 10,
	icon = 5,
	cost = 9,
	effect = 16,
	timesLimit = 18,
	roundLimit = 17,
	target = 12,
	assassinHeroId = 3,
	careerId = 2,
	triggerNode = 15
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
