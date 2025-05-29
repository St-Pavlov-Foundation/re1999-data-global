module("modules.configs.excel2json.lua_activity188_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 4,
	effect = 3,
	skillId = 2,
	activityId = 1,
	desc = 5
}
local var_0_2 = {
	"activityId",
	"skillId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
