module("modules.configs.excel2json.lua_activity194_progress_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roundRange = 5,
	energyRange = 3,
	energyDesc = 4,
	type = 2,
	roundDesc = 6,
	condition = 1
}
local var_0_2 = {
	"condition"
}
local var_0_3 = {
	energyDesc = 1,
	roundDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
