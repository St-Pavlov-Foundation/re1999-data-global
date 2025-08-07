module("modules.configs.excel2json.lua_assassin_style_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	allLimit = 3,
	icon = 6,
	skillId = 1,
	roundLimit = 2,
	itemSpace = 5,
	desc = 4
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
