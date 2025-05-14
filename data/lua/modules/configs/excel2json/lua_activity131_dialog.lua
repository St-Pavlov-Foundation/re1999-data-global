module("modules.configs.excel2json.lua_activity131_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 4,
	single = 6,
	option_param = 5,
	type = 3,
	id = 1,
	stepId = 2,
	content = 8,
	speaker = 7
}
local var_0_2 = {
	"id",
	"stepId"
}
local var_0_3 = {
	speaker = 1,
	content = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
