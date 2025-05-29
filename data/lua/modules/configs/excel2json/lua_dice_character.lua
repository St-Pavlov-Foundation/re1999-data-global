module("modules.configs.excel2json.lua_dice_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	relicIds = 7,
	name = 2,
	dicelist = 5,
	skilllist = 6,
	power = 10,
	resetTimes = 8,
	powerSkill = 11,
	desc = 3,
	hp = 9,
	id = 1,
	icon = 4
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
