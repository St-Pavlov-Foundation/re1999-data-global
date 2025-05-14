module("modules.configs.excel2json.lua_store_entrance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 4,
	prefab = 6,
	nameEn = 5,
	openId = 10,
	activityId = 11,
	openTime = 12,
	belongFirstTab = 2,
	belongSecondTab = 3,
	storeId = 14,
	openHideId = 15,
	endTime = 13,
	id = 1,
	icon = 7,
	showCost = 9,
	order = 8
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
