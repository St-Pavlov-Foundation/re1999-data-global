﻿module("modules.configs.excel2json.lua_skill_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	behavior9 = 67,
	conditionTarget5 = 42,
	condition8 = 59,
	roundLimit3 = 34,
	limit5 = 45,
	isExtra = 7,
	bigSkillPoint = 10,
	condition4 = 35,
	clientIgnoreCondition = 8,
	roundLimit6 = 52,
	conditionTarget1 = 18,
	needExPoint = 5,
	conditionTarget4 = 36,
	effectTag = 13,
	conditionTarget7 = 54,
	condition7 = 53,
	condition6 = 47,
	condition3 = 29,
	behaviorTarget1 = 20,
	condition2 = 23,
	behaviorTarget2 = 26,
	logicTarget = 16,
	conditionTarget3 = 30,
	roundLimit5 = 46,
	conditionTarget6 = 48,
	behavior1 = 19,
	roundLimit8 = 64,
	limit1 = 21,
	id = 1,
	condition10 = 71,
	roundLimit9 = 70,
	behaviorTarget10 = 74,
	conditionTarget2 = 24,
	roundLimit2 = 28,
	behavior10 = 73,
	condition5 = 41,
	conditionTarget10 = 72,
	behavior3 = 31,
	behaviorTarget7 = 56,
	behavior2 = 25,
	roundLimit10 = 76,
	limit4 = 39,
	limit9 = 69,
	condition9 = 65,
	isBigSkill = 4,
	limit8 = 63,
	roundLimit4 = 40,
	behaviorTarget5 = 44,
	conditionTarget9 = 66,
	behaviorTarget6 = 50,
	behaviorTarget9 = 68,
	skillEffectType = 6,
	type = 3,
	conditionTarget8 = 60,
	limit3 = 33,
	limit2 = 27,
	powerCost = 9,
	limit7 = 57,
	behaviorTarget4 = 38,
	limit6 = 51,
	behaviorTarget8 = 62,
	condition1 = 17,
	behavior8 = 61,
	targetLimit = 11,
	desc = 2,
	roundLimit7 = 58,
	roundLimit1 = 22,
	behavior5 = 43,
	showTag = 12,
	behavior4 = 37,
	damageRate = 15,
	resistancesTag = 14,
	limit10 = 75,
	behavior7 = 55,
	behaviorTarget3 = 32,
	behavior6 = 49
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
