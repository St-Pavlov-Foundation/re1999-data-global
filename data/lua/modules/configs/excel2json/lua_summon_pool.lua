-- chunkname: @modules/configs/excel2json/lua_summon_pool.lua

module("modules.configs.excel2json.lua_summon_pool", package.seeall)

local lua_summon_pool = {}
local fields = {
	awardTime = 25,
	cost1 = 15,
	guaranteeSRParam = 24,
	type = 4,
	characterDetail = 28,
	priorCost1 = 17,
	initWeight = 21,
	discountTime10 = 19,
	upWeight = 23,
	priority = 2,
	advertising = 10,
	nameUnderlayColor = 33,
	priorCost10 = 18,
	ticketId = 6,
	ornamentName = 34,
	totalPosibility = 36,
	progressRewardPrefab = 37,
	progressRewards = 29,
	jumpGroupId = 31,
	banner = 11,
	mailIds = 32,
	prefabPath = 13,
	bannerLineName = 35,
	id = 1,
	poolDetail = 27,
	totalFreeCount = 3,
	nameEn = 8,
	desc = 9,
	nameCn = 7,
	changeWeight = 26,
	doubleSsrUpRates = 22,
	param = 5,
	historyShowType = 30,
	cost10 = 16,
	discountCost10 = 20,
	bannerFlag = 12,
	customClz = 14
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
