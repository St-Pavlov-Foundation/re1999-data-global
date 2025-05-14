module("modules.configs.excel2json.lua_activity168_option", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	name = 3,
	costItems = 6,
	effectId = 5,
	mustDrop = 7,
	optionId = 2,
	desc = 4
}
local var_0_2 = {
	"activityId",
	"optionId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
