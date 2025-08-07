module("modules.configs.excel2json.lua_assassin_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	title = 2,
	bgCenter = 5,
	id = 1,
	bg = 4,
	unlock = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
