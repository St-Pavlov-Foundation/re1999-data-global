module("modules.configs.excel2json.lua_rouge_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	descExtra = 6,
	name = 2,
	descType = 5,
	effectId = 3,
	id = 1,
	descSimply = 7,
	descExtraSimply = 8,
	desc = 4
}
local var_0_2 = {
	"id",
	"effectId"
}
local var_0_3 = {
	descExtra = 3,
	descSimply = 4,
	name = 1,
	descExtraSimply = 5,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
