module("modules.configs.excel2json.lua_rouge_style", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	coin = 8,
	name = 4,
	talentPointGroup = 17,
	layoutId = 11,
	season = 1,
	mapSkills = 15,
	passiveSkillDescs = 12,
	desc = 5,
	unlockType = 18,
	capacity = 7,
	talentSkill = 16,
	power = 9,
	icon = 6,
	unlockParam = 19,
	halfCost = 20,
	activeSkills = 14,
	passiveSkillDescs2 = 13,
	id = 2,
	version = 3,
	powerLimit = 10
}
local var_0_2 = {
	"season",
	"id"
}
local var_0_3 = {
	passiveSkillDescs2 = 4,
	name = 1,
	passiveSkillDescs = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
