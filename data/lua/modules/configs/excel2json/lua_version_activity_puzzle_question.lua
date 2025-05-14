module("modules.configs.excel2json.lua_version_activity_puzzle_question", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	text = 3,
	answer = 4,
	tittle = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	text = 2,
	answer = 3,
	tittle = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
