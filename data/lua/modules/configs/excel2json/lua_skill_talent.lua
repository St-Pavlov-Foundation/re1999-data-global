module("modules.configs.excel2json.lua_skill_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	newSkills0 = 6,
	newSkills5 = 16,
	newSkills2 = 10,
	exchangeSkills4 = 13,
	sub = 2,
	newSkills3 = 12,
	exchangeSkills1 = 7,
	desc = 4,
	exchangeSkills3 = 11,
	newSkills4 = 14,
	newSkills1 = 8,
	exchangeSkills2 = 9,
	exchangeSkills0 = 5,
	exchangeSkills5 = 15,
	talentId = 1,
	level = 3
}
local var_0_2 = {
	"talentId",
	"sub"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
