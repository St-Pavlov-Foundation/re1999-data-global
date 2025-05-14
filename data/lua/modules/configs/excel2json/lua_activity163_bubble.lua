module("modules.configs.excel2json.lua_activity163_bubble", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stepId = 2,
	direction = 5,
	nextStep = 3,
	content = 6,
	id = 1,
	bubbleType = 4
}
local var_0_2 = {
	"id",
	"stepId"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
