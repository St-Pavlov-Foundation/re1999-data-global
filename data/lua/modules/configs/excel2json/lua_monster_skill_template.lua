module("modules.configs.excel2json.lua_monster_skill_template", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	gender = 7,
	name = 2,
	career = 8,
	baseStress = 18,
	uniqueSkill = 12,
	uniqueSkill_point = 13,
	nameEng = 3,
	identity = 20,
	race = 21,
	camp = 17,
	dmgType = 9,
	activeSkill = 11,
	powerMax = 15,
	des = 4,
	passiveSkill = 10,
	instance = 6,
	property = 16,
	resistance = 14,
	template = 5,
	id = 1,
	maxStress = 19
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	property = 3,
	name = 1,
	des = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
