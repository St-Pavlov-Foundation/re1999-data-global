module("modules.configs.excel2json.lua_activity101_dragonboat", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 4,
	name = 3,
	dayicon = 5,
	activityId = 1,
	day = 2
}
local var_0_2 = {
	"activityId",
	"day"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
