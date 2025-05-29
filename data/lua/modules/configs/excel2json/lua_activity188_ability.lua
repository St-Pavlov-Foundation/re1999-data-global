module("modules.configs.excel2json.lua_activity188_ability", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectTime = 3,
	skillId = 4,
	abilityId = 2,
	activityId = 1,
	desc = 5
}
local var_0_2 = {
	"activityId",
	"abilityId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
