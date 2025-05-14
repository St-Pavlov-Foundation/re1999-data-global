module("modules.configs.excel2json.lua_activity181_box", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	showOnlineTime = 2,
	bonus = 5,
	obtainStart = 7,
	obtainTimes = 9,
	showOfflineTime = 3,
	obtainType = 6,
	totalBox = 4,
	activityId = 1,
	obtainEnd = 8
}
local var_0_2 = {
	"activityId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
