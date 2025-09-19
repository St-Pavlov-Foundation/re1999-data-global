module("modules.configs.excel2json.lua_monster", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heartVariantId = 7,
	highPriorityName = 19,
	levelEasy = 23,
	uniqueSkillLevel = 11,
	skillTemplate = 3,
	initial_uniqueSkill_point = 10,
	career = 6,
	level_true = 9,
	label = 5,
	highPriorityNameEng = 20,
	hpSign = 15,
	highPriorityDes = 21,
	effectHangPoint = 18,
	templateEasy = 22,
	skinId = 4,
	level = 8,
	effect = 17,
	passiveSkillsEx = 13,
	energySign = 16,
	uiFilterSkill = 14,
	passiveSkillCount = 12,
	template = 2,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	highPriorityDes = 2,
	highPriorityName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
