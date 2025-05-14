module("modules.configs.excel2json.lua_trigger", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	param2 = 8,
	param4 = 10,
	param1 = 7,
	param8 = 14,
	limitOneTurn = 6,
	limit = 5,
	param7 = 13,
	triggerType = 3,
	param6 = 12,
	param10 = 16,
	param5 = 11,
	battleId = 2,
	actionList = 4,
	param9 = 15,
	param3 = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
