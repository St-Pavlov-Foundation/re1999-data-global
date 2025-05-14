module("modules.configs.excel2json.lua_activity174_role", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroId = 8,
	name = 9,
	quality = 6,
	skinId = 5,
	season = 2,
	gender = 10,
	career = 11,
	activeSkill2 = 16,
	type = 3,
	activeSkill1 = 15,
	dmgType = 12,
	uniqueSkill = 17,
	coinValue = 20,
	uniqueSkill_point = 18,
	powerMax = 19,
	passiveSkill = 13,
	rare = 7,
	template = 4,
	id = 1,
	replacePassiveSkill = 14
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
