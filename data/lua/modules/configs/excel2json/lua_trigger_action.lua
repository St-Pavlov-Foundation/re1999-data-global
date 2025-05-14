module("modules.configs.excel2json.lua_trigger_action", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param15 = 17,
	param1 = 3,
	actionType = 2,
	param12 = 14,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param2 = 4,
	param14 = 16,
	param13 = 15,
	param9 = 11,
	param7 = 9,
	param11 = 13,
	param10 = 12,
	id = 1,
	param4 = 6,
	param3 = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
