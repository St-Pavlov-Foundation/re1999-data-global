module("modules.configs.excel2json.lua_activity174_bag", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	season = 3,
	bagDesc = 8,
	costCoin = 6,
	type = 4,
	heroNum = 11,
	heroParam = 10,
	collectionType = 12,
	activityId = 2,
	collectionNum = 14,
	quality = 5,
	heroType = 9,
	enhanceNum = 17,
	collectionParam = 13,
	enhanceType = 15,
	id = 1,
	bagTitle = 7,
	enhanceParam = 16
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	bagDesc = 2,
	bagTitle = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
