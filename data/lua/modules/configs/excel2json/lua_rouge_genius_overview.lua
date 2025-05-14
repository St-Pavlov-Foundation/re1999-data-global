module("modules.configs.excel2json.lua_rouge_genius_overview", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 2,
	ismul = 4,
	id = 1,
	value = 3,
	icon = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
