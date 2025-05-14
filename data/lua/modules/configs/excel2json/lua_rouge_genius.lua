module("modules.configs.excel2json.lua_rouge_genius", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 6,
	name = 3,
	id = 2,
	season = 1,
	icon = 4,
	desc = 5
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
