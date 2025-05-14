module("modules.configs.excel2json.lua_hero_trial_attr", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	defense = 9,
	name = 2,
	technic = 11,
	dropDmg = 17,
	uniqueSkill = 5,
	activeSkill = 3,
	addDmg = 16,
	criDmg = 14,
	attack = 8,
	criDef = 15,
	passiveSkill = 4,
	cri = 12,
	mdefense = 10,
	recri = 13,
	noShowExSkill = 6,
	life = 7,
	id = 1
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
