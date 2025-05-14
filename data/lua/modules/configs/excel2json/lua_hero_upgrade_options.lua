module("modules.configs.excel2json.lua_hero_upgrade_options", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	unlockCondition = 2,
	addBuff = 11,
	replaceBigSkill = 8,
	replaceSkillGroup1 = 6,
	delBuff = 12,
	title = 3,
	desc = 4,
	replaceSkillGroup2 = 7,
	id = 1,
	addPassiveSkill = 10,
	showSkillId = 5,
	replacePassiveSkill = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
