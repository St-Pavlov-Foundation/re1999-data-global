module("modules.configs.excel2json.lua_activity_nuodika_180_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	initVisible = 4,
	eventId = 1,
	eventParam = 3,
	eventType = 2
}
local var_0_2 = {
	"eventId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
