module("modules.configs.excel2json.lua_survival_tree_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nodeId = 2,
	result = 6,
	id = 1,
	icon = 4,
	condition = 5,
	desc = 3
}
local var_0_2 = {
	"id",
	"nodeId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
