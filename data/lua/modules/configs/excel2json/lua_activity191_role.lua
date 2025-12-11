module("modules.configs.excel2json.lua_activity191_role", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roleId = 10,
	name = 11,
	type = 3,
	skinId = 5,
	uniqueSkill = 18,
	gender = 12,
	career = 13,
	activeSkill2 = 17,
	star = 7,
	activeSkill1 = 16,
	dmgType = 14,
	quality = 6,
	tag = 9,
	uniqueSkill_point = 19,
	activityId = 2,
	powerMax = 20,
	facetsId = 21,
	passiveSkill = 15,
	exLevel = 8,
	template = 4,
	id = 1,
	weight = 22
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
