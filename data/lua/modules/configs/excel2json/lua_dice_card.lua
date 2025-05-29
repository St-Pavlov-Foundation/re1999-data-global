module("modules.configs.excel2json.lua_dice_card", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effect1 = 6,
	bufflist = 16,
	name = 2,
	type = 5,
	effect3 = 12,
	aim1 = 8,
	aim3 = 14,
	desc = 3,
	allRoundLimitCount = 18,
	params2 = 10,
	roundLimitCount = 17,
	effect2 = 9,
	patternlist = 15,
	quality = 4,
	spiritskilltype = 19,
	aim2 = 11,
	powerExtendRule = 20,
	params3 = 13,
	id = 1,
	params1 = 7
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
