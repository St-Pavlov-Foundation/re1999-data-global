module("modules.configs.excel2json.lua_assassin_stealth_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	mission = 4,
	player = 5,
	id = 1,
	title = 2,
	forbidScaleGuide = 6,
	born = 3
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
