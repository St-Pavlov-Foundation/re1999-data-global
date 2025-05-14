module("modules.configs.excel2json.lua_rouge_choice", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	interactive = 8,
	display = 9,
	selectedDesc = 7,
	unlockParam = 4,
	title = 5,
	desc = 6,
	unlockType = 3,
	id = 1,
	version = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 1,
	selectedDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
