-- chunkname: @modules/configs/excel2json/lua_store_goods.lua

module("modules.configs.excel2json.lua_store_goods", package.seeall)

local lua_store_goods = {}
local fields = {
	needWeekwalkLayer = 24,
	name = 9,
	buyLevel = 25,
	preGoodsId = 15,
	needTopup = 16,
	skinLevel = 33,
	openLevel = 14,
	discountItem = 36,
	onlineTime = 18,
	showLinkageLogo = 38,
	duration = 17,
	activityId = 28,
	jumpId = 30,
	newStartTime = 26,
	offTag = 11,
	islinkageSkin = 37,
	newEndTime = 27,
	bigImg = 8,
	product = 2,
	id = 1,
	showRefreshTime = 21,
	nameEn = 10,
	refreshTime = 20,
	needEpisodeId = 23,
	bindgoodid = 29,
	logoRoots = 39,
	isAdvancedSkin = 31,
	cost2 = 5,
	originalCost = 12,
	notShowInRecommend = 32,
	order = 22,
	cost = 4,
	isOnline = 13,
	offlineTime = 19,
	deductionItem = 34,
	maxBuyCount = 3,
	reduction = 6,
	spineParams = 35,
	storeId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	offTag = 2,
	name = 1
}

function lua_store_goods.onLoad(json)
	lua_store_goods.configList, lua_store_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_goods
