module("modules.configs.excel2json.lua_assassin_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	targetCheck = 15,
	name = 4,
	count = 6,
	roundLimit = 9,
	stealthEffDesc = 12,
	targetEff = 17,
	fightEffDesc = 11,
	unlock = 13,
	effect = 7,
	param = 8,
	itemType = 2,
	skillId = 18,
	icon = 5,
	level = 3,
	itemId = 1,
	range = 14,
	costPoint = 10,
	target = 16
}
local var_0_2 = {
	"itemId"
}
local var_0_3 = {
	fightEffDesc = 2,
	name = 1,
	stealthEffDesc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
