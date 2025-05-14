module("modules.configs.excel2json.lua_rouge_result", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 2,
	priority = 5,
	triggerParam = 7,
	type = 3,
	season = 1,
	trigger = 6,
	desc = 4
}
local var_0_2 = {
	"season",
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
