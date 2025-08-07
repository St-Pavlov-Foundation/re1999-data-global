module("modules.configs.excel2json.lua_assassin_home", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	unlock = 5,
	effect = 7,
	unlockDesc = 6,
	type = 3,
	id = 1,
	title = 2,
	effectDesc = 8,
	level = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	effectDesc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
