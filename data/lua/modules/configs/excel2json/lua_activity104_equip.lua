module("modules.configs.excel2json.lua_activity104_equip", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	iconOffset = 7,
	name = 2,
	attrId = 9,
	signIcon = 6,
	isOptional = 4,
	career = 11,
	rare = 3,
	careerIcon = 12,
	equipId = 1,
	signOffset = 8,
	group = 13,
	skillId = 10,
	tag = 15,
	icon = 5,
	activityId = 14
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
