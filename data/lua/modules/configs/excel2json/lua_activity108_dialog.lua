module("modules.configs.excel2json.lua_activity108_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 4,
	stepId = 2,
	option_param = 5,
	type = 3,
	id = 1,
	result = 6,
	content = 7
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
