module("modules.configs.excel2json.lua_dice_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerPoint = 8,
	effect = 7,
	name = 2,
	tag = 3,
	param = 9,
	damp = 10,
	roundLimitCount = 11,
	desc = 4,
	visible = 6,
	id = 1,
	icon = 5,
	allRoundLimitCount = 12
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
