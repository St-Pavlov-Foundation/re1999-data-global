module("modules.configs.excel2json.lua_handbook_skin_high", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	scenePath = 7,
	name = 2,
	order = 5,
	des = 6,
	show = 4,
	iconRes = 9,
	id = 1,
	nameRes = 8,
	nameEn = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	des = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
