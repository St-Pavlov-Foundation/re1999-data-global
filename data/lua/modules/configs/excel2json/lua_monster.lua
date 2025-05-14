module("modules.configs.excel2json.lua_monster", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heartVariantId = 7,
	highPriorityName = 18,
	levelEasy = 22,
	uniqueSkillLevel = 10,
	skillTemplate = 3,
	initial_uniqueSkill_point = 9,
	career = 6,
	label = 5,
	highPriorityNameEng = 19,
	highPriorityDes = 20,
	hpSign = 14,
	templateEasy = 21,
	effectHangPoint = 17,
	skinId = 4,
	level = 8,
	effect = 16,
	passiveSkillsEx = 12,
	energySign = 15,
	uiFilterSkill = 13,
	passiveSkillCount = 11,
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
