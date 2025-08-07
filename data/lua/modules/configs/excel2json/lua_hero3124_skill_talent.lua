module("modules.configs.excel2json.lua_hero3124_skill_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fieldActivateDesc = 9,
	name = 4,
	additionalFieldDesc4 = 34,
	exchangeSkills1 = 18,
	additionalFieldDesc3 = 28,
	fieldDesc2 = 20,
	newSkills2 = 23,
	fieldDesc3 = 26,
	fieldActivateDesc1 = 15,
	desc2 = 19,
	exchangeSkills3 = 30,
	newSkills1 = 17,
	fieldDesc = 8,
	icon = 5,
	newSkills3 = 29,
	level = 3,
	exchangeSkills2 = 24,
	fieldActivateDesc3 = 27,
	newSkills4 = 35,
	additionalFieldDesc = 10,
	sub = 2,
	exchangeSkills4 = 36,
	desc5 = 37,
	fieldDesc5 = 38,
	additionalFieldDesc5 = 40,
	exchangeSkills5 = 42,
	talentId = 1,
	desc3 = 25,
	desc1 = 13,
	desc4 = 31,
	desc = 7,
	fieldDesc1 = 14,
	fieldActivateDesc2 = 21,
	newSkills0 = 11,
	newSkills5 = 41,
	fieldActivateDesc5 = 39,
	additionalFieldDesc2 = 22,
	additionalFieldDesc1 = 16,
	fieldActivateDesc4 = 33,
	fieldName = 6,
	exchangeSkills0 = 12,
	fieldDesc4 = 32
}
local var_0_2 = {
	"talentId"
}
local var_0_3 = {
	fieldActivateDesc = 5,
	name = 1,
	additionalFieldDesc4 = 22,
	desc1 = 7,
	additionalFieldDesc3 = 18,
	desc = 3,
	fieldDesc = 4,
	fieldDesc3 = 16,
	fieldActivateDesc1 = 9,
	desc2 = 11,
	desc4 = 19,
	fieldDesc1 = 8,
	fieldActivateDesc2 = 13,
	fieldDesc2 = 12,
	desc5 = 23,
	fieldDesc5 = 24,
	additionalFieldDesc5 = 26,
	fieldActivateDesc5 = 25,
	additionalFieldDesc = 6,
	fieldActivateDesc3 = 17,
	additionalFieldDesc2 = 14,
	additionalFieldDesc1 = 10,
	fieldActivateDesc4 = 21,
	fieldName = 2,
	fieldDesc4 = 20,
	desc3 = 15
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
