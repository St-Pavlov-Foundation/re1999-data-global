-- chunkname: @modules/configs/excel2json/lua_store_goods.lua

module("modules.configs.excel2json.lua_store_goods", package.seeall)

local lua_store_goods = {}
local fields = {
	buyLevel = 27,
	name = 9,
	needTopup = 18,
	preGoodsId = 17,
	needWeekwalkLayer = 26,
	skinLevel = 35,
	openLevel = 16,
	discountItem = 38,
	onlineTime = 20,
	showLinkageLogo = 40,
	duration = 19,
	activityId = 30,
	jumpId = 32,
	newStartTime = 28,
	offTag = 11,
	islinkageSkin = 39,
	newEndTime = 29,
	bigImg = 8,
	product = 2,
	id = 1,
	showRefreshTime = 23,
	nameEn = 10,
	refreshTime = 22,
	needEpisodeId = 25,
	bindgoodid = 31,
	logoRoots = 41,
	isAdvancedSkin = 33,
	cost2 = 5,
	originalCost = 14,
	slogan = 13,
	notShowInRecommend = 34,
	underlay = 12,
	order = 24,
	cost = 4,
	isOnline = 15,
	offlineTime = 21,
	deductionItem = 36,
	maxBuyCount = 3,
	reduction = 6,
	spineParams = 37,
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
