module("modules.configs.excel2json.lua_activity191_node", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	selectNum = 4,
	ruleId = 1,
	random = 3,
	node = 2,
	desc = 5
}
local var_0_2 = {
	"ruleId",
	"node"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
