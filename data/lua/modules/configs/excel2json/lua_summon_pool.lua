-- chunkname: @modules/configs/excel2json/lua_summon_pool.lua

module("modules.configs.excel2json.lua_summon_pool", package.seeall)

local lua_summon_pool = {}
local fields = {
	awardTime = 27,
	guaranteeSRParam = 26,
	initWeight = 23,
	type = 6,
	characterDetail = 30,
	free10MaxUseCount = 5,
	cost10 = 18,
	cost1 = 17,
	upWeight = 25,
	priorCost1 = 19,
	advertising = 12,
	nameUnderlayColor = 35,
	jumpGroupId = 33,
	mailIds = 34,
	priority = 2,
	ornamentName = 36,
	totalPosibility = 38,
	progressRewards = 31,
	progressRewardPrefab = 39,
	ticketId = 8,
	banner = 13,
	priorCost10 = 20,
	prefabPath = 15,
	bannerLineName = 37,
	id = 1,
	poolDetail = 29,
	totalFreeCount = 3,
	nameEn = 10,
	desc = 11,
	nameCn = 9,
	changeWeight = 28,
	doubleSsrUpRates = 24,
	param = 7,
	historyShowType = 32,
	discountTime10 = 21,
	dailyFreeSummon10Count = 4,
	discountCost10 = 22,
	bannerFlag = 14,
	customClz = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameCn = 1
}

function lua_summon_pool.onLoad(json)
	lua_summon_pool.configList, lua_summon_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool
