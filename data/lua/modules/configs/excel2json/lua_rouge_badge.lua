module("modules.configs.excel2json.lua_rouge_badge", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 8,
	name = 3,
	triggerParam = 7,
	id = 2,
	season = 1,
	icon = 5,
	trigger = 6,
	desc = 4
}
local var_0_2 = {
	"season",
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
