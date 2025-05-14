module("modules.configs.excel2json.lua_activity168_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	optionIds = 4,
	eventId = 2,
	activityId = 1,
	name = 3
}
local var_0_2 = {
	"activityId",
	"eventId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
