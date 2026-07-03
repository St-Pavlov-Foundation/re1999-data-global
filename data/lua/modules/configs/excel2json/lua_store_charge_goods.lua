-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	price = 16,
	name = 5,
	currencyCodezh = 20,
	pricetw = 28,
	type = 3,
	pricezh = 19,
	currencyCodejp = 23,
	pricekr = 25,
	onlineTime = 14,
	originalCostzh = 21,
	originalCostkr = 27,
	extraDiamond = 33,
	limit = 35,
	newStartTime = 37,
	newEndTime = 38,
	originalCostGoodsId = 40,
	quickUseItemList = 43,
	originalCostjp = 24,
	item = 34,
	offTag = 12,
	showLogoTag = 46,
	overviewJumpId = 47,
	country = 39,
	firstDiamond = 32,
	bigImg = 8,
	diamond = 31,
	product = 9,
	id = 1,
	currencyCodekr = 26,
	nameEn = 6,
	taskid = 45,
	detailDesc = 42,
	belongStoreId = 2,
	desc = 7,
	originalCost = 18,
	slogan = 11,
	notShowInRecommend = 41,
	underlay = 10,
	currencyCodetw = 29,
	order = 4,
	showLinkageTag = 44,
	isOnline = 13,
	originalCosttw = 30,
	offlineTime = 15,
	pricejp = 22,
	isShowTurnback = 48,
	currencyCode = 17,
	preGoodsId = 36
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
