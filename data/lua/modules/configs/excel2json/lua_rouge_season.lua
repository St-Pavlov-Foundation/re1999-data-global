module("modules.configs.excel2json.lua_rouge_season", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	season = 2,
	name = 4,
	desc = 6,
	id = 1,
	version = 3,
	enName = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 3,
	name = 1,
	enName = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
