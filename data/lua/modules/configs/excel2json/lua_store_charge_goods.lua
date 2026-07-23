-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	price = 17,
	name = 5,
	currencyCodezh = 21,
	pricetw = 29,
	type = 3,
	pricezh = 20,
	currencyCodejp = 24,
	pricekr = 26,
	onlineTime = 15,
	originalCostzh = 22,
	originalCostkr = 28,
	extraDiamond = 34,
	limit = 36,
	newStartTime = 38,
	newEndTime = 39,
	originalCostGoodsId = 41,
	quickUseItemList = 44,
	originalCostjp = 25,
	item = 35,
	offTag = 13,
	newShowLinkTag = 47,
	newshowLinkTag = 48,
	country = 40,
	firstDiamond = 33,
	bigImg = 8,
	diamond = 32,
	product = 9,
	showLogoTag = 49,
	id = 1,
	overviewJumpId = 50,
	currencyCodekr = 27,
	nameEn = 6,
	taskid = 46,
	isShowTurnback = 51,
	detailDesc = 43,
	belongStoreId = 2,
	desc = 7,
	originalCost = 19,
	slogan = 12,
	notShowInRecommend = 42,
	underlay = 10,
	currencyCodetw = 30,
	order = 4,
	showLinkageTag = 45,
	isOnline = 14,
	originalCosttw = 31,
	offlineTime = 16,
	pricejp = 23,
	showBg = 11,
	currencyCode = 18,
	preGoodsId = 37
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	detailDesc = 3,
	name = 1,
	slogan = 2
}

function lua_store_charge_goods.onLoad(json)
	lua_store_charge_goods.configList, lua_store_charge_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge_goods
