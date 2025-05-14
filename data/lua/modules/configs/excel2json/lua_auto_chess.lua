module("modules.configs.excel2json.lua_auto_chess", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	star = 2,
	name = 5,
	id = 1,
	type = 3,
	attack = 9,
	attackMode = 13,
	image = 18,
	race = 6,
	moveType = 14,
	tag = 8,
	skillDesc = 12,
	skillIds = 11,
	fixExp = 16,
	subRace = 7,
	hp = 10,
	specialShopCost = 15,
	levelFromMall = 4,
	initBuff = 17
}
local var_0_2 = {
	"id",
	"star"
}
local var_0_3 = {
	skillDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
