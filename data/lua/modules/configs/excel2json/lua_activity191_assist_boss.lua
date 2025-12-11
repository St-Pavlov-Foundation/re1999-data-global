module("modules.configs.excel2json.lua_activity191_assist_boss", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	passiveSkills = 14,
	powerMax = 10,
	skinId = 7,
	uniqueSkill = 13,
	gender = 8,
	career = 6,
	activeSkill2 = 12,
	condition = 5,
	activeSkill1 = 11,
	dmgType = 9,
	name = 2,
	relation = 4,
	icon = 18,
	activityId = 3,
	headIcon = 17,
	offset = 16,
	uiForm = 15,
	bossDesc = 19
}
local var_0_2 = {
	"bossId"
}
local var_0_3 = {
	bossDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
