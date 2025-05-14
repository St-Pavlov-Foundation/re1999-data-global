module("modules.configs.excel2json.lua_activity147", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 6,
	descList = 2,
	spineRes = 4,
	rewardList = 3,
	dialogs = 5,
	activityId = 1
}
local var_0_2 = {
	"activityId"
}
local var_0_3 = {
	descList = 1,
	dialogs = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
