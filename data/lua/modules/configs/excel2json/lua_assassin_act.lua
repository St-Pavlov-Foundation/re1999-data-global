module("modules.configs.excel2json.lua_assassin_act", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 8,
	name = 2,
	icon = 3,
	type = 7,
	id = 1,
	effectId = 10,
	desc = 9,
	audioId = 5,
	power = 6,
	showImg = 4,
	targetEffectId = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
