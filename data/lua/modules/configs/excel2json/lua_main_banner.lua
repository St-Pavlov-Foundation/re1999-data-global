module("modules.configs.excel2json.lua_main_banner", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sortId = 4,
	name = 2,
	jumpId = 5,
	appearanceRole = 7,
	id = 1,
	icon = 3,
	startEnd = 6,
	vanishingRule = 8
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
