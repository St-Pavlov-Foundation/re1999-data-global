module("modules.configs.excel2json.lua_linkage_activity", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	item1 = 7,
	activityId = 1,
	showOnlineTime = 2,
	desc1 = 9,
	item2 = 8,
	showOfflineTime = 3,
	res_video2 = 5,
	desc2 = 10,
	res_video1 = 4,
	systemJumpCode = 6
}
local var_0_2 = {
	"activityId"
}
local var_0_3 = {
	desc2 = 2,
	desc1 = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
