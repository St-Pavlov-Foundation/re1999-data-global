module("modules.configs.excel2json.lua_activity144_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eventId = 2,
	name = 6,
	eventType = 7,
	optionIds = 3,
	picture = 4,
	activityId = 1,
	desc = 5
}
local var_0_2 = {
	"activityId",
	"eventId"
}
local var_0_3 = {
	name = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
