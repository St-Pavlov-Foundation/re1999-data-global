module("modules.configs.excel2json.lua_activity194_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 7,
	name = 5,
	picture = 4,
	eventGroup = 2,
	eventType = 9,
	eventId = 1,
	trigger = 3,
	number = 6,
	optionIds = 8,
	position = 10
}
local var_0_2 = {
	"eventId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
