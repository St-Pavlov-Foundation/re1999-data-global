module("modules.configs.excel2json.lua_activity174_test_role", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroId = 7,
	name = 8,
	costCoin = 19,
	type = 2,
	uniqueSkill = 16,
	gender = 9,
	career = 10,
	activeSkill2 = 15,
	quality = 5,
	activeSkill1 = 14,
	dmgType = 11,
	uniqueSkill_point = 17,
	skinId = 4,
	powerMax = 18,
	passiveSkill = 12,
	rare = 6,
	template = 3,
	id = 1,
	replacePassiveSkill = 13
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
