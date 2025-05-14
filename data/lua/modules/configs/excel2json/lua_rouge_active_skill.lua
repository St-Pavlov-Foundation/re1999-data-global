module("modules.configs.excel2json.lua_rouge_active_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roundLimit = 5,
	icon = 8,
	coinCost = 4,
	allLimit = 6,
	id = 1,
	version = 2,
	powerCost = 3,
	desc = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
