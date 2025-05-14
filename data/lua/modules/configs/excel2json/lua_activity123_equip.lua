module("modules.configs.excel2json.lua_activity123_equip", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isMain = 4,
	name = 2,
	teamLimit = 15,
	indexLimit = 17,
	decomposeGet = 18,
	composeCost = 19,
	equipId = 1,
	signOffset = 9,
	skillId = 11,
	tag = 14,
	icon = 6,
	activityId = 13,
	packageId = 5,
	specialEffect = 16,
	attrId = 10,
	group = 12,
	rare = 3,
	signIcon = 7,
	iconOffset = 8
}
local var_0_2 = {
	"equipId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
