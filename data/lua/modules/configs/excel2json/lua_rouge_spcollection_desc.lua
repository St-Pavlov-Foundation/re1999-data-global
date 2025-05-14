module("modules.configs.excel2json.lua_rouge_spcollection_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	descSimply = 6,
	conditionSimply = 5,
	effectId = 2,
	id = 1,
	condition = 3,
	desc = 4
}
local var_0_2 = {
	"id",
	"effectId"
}
local var_0_3 = {
	conditionSimply = 3,
	descSimply = 4,
	condition = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
