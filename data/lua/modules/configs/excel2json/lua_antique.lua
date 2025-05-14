module("modules.configs.excel2json.lua_antique", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sources = 10,
	name = 2,
	storyId = 11,
	nameen = 3,
	effect = 13,
	title = 7,
	desc = 9,
	titleen = 8,
	gifticon = 5,
	sign = 6,
	id = 1,
	icon = 4,
	iconArea = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 2,
	name = 1,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
