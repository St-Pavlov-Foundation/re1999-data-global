module("modules.configs.excel2json.lua_summon_pool", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	ornamentName = 31,
	guaranteeSRParam = 22,
	priority = 2,
	type = 4,
	characterDetail = 26,
	discountTime10 = 17,
	upWeight = 21,
	initWeight = 19,
	advertising = 10,
	ticketId = 6,
	awardTime = 23,
	nameUnderlayColor = 30,
	totalPosibility = 33,
	cost1 = 15,
	jumpGroupId = 28,
	banner = 11,
	mailIds = 29,
	prefabPath = 13,
	bannerLineName = 32,
	id = 1,
	poolDetail = 25,
	totalFreeCount = 3,
	nameEn = 8,
	desc = 9,
	nameCn = 7,
	changeWeight = 24,
	doubleSsrUpRates = 20,
	param = 5,
	historyShowType = 27,
	cost10 = 16,
	discountCost10 = 18,
	bannerFlag = 12,
	customClz = 14
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	nameCn = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
