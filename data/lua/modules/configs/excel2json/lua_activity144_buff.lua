module("modules.configs.excel2json.lua_activity144_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectParam = 5,
	effectType = 4,
	buffId = 2,
	type = 3,
	effectDesc = 6,
	reduction = 7,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"buffId"
}
local var_0_3 = {
	effectDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
