module("modules.configs.excel2json.lua_balance_umbrella", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	players = 5,
	name = 3,
	id = 1,
	episode = 2,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	players = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
