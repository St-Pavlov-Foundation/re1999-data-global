module("modules.configs.excel2json.lua_rouge_risk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	buffNum = 7,
	range = 4,
	scoreReward = 8,
	title = 2,
	content = 6,
	desc = 5,
	title_en = 3,
	id = 1,
	viewDown = 10,
	attr = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title_en = 2,
	title = 1,
	content = 4,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
