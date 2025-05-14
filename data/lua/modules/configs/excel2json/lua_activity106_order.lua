module("modules.configs.excel2json.lua_activity106_order", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	gameSetting = 14,
	name = 4,
	titledesc = 5,
	openDay = 11,
	infoDesc = 17,
	desc = 6,
	listenerParam = 9,
	maxProgress = 10,
	activityId = 1,
	order = 15,
	jumpId = 16,
	location = 7,
	rare = 3,
	listenerType = 8,
	id = 2,
	bossPic = 13,
	bonus = 12
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1,
	location = 4,
	titledesc = 2,
	infoDesc = 5,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
