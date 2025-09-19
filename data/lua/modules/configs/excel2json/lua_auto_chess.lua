module("modules.configs.excel2json.lua_auto_chess", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	attackMode = 14,
	name = 6,
	tag = 9,
	type = 4,
	skillDesc = 13,
	cds = 17,
	specialShopCost = 18,
	image = 21,
	race = 7,
	moveType = 15,
	attack = 10,
	star = 2,
	skillIds = 12,
	illustrationShow = 3,
	durability = 16,
	fixExp = 19,
	subRace = 8,
	hp = 11,
	id = 1,
	levelFromMall = 5,
	initBuff = 20
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
