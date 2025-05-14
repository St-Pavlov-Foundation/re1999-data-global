module("modules.configs.excel2json.lua_activity144_record_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eventIds = 5,
	name = 3,
	unLockDesc = 4,
	recordId = 2,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"recordId"
}
local var_0_3 = {
	unLockDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
