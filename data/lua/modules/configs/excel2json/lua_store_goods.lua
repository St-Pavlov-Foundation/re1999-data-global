-- chunkname: @modules/configs/excel2json/lua_store_goods.lua

module("modules.configs.excel2json.lua_store_goods", package.seeall)

local lua_store_goods = {}
local fields = {
	needWeekwalkLayer = 23,
	name = 9,
	offlineTime = 19,
	buyLevel = 24,
	preGoodsId = 15,
	needTopup = 16,
	openLevel = 14,
	discountItem = 35,
	onlineTime = 18,
	showLinkageLogo = 37,
	duration = 17,
	activityId = 27,
	jumpId = 29,
	newStartTime = 25,
	offTag = 11,
	islinkageSkin = 36,
	newEndTime = 26,
	bigImg = 8,
	product = 2,
	id = 1,
	nameEn = 10,
	refreshTime = 20,
	needEpisodeId = 22,
	bindgoodid = 28,
	logoRoots = 38,
	isAdvancedSkin = 30,
	cost2 = 5,
	originalCost = 12,
	notShowInRecommend = 31,
	order = 21,
	cost = 4,
	isOnline = 13,
	skinLevel = 32,
	deductionItem = 33,
	maxBuyCount = 3,
	reduction = 6,
	spineParams = 34,
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
