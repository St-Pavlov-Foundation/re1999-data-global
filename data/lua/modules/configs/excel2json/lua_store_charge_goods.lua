-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	firstDiamond = 30,
	name = 5,
	originalCostzh = 19,
	pricetw = 26,
	currencyCodezh = 18,
	type = 3,
	currencyCodejp = 21,
	pricekr = 23,
	onlineTime = 12,
	pricezh = 17,
	originalCostkr = 25,
	price = 14,
	limit = 33,
	newStartTime = 35,
	newEndTime = 36,
	originalCostGoodsId = 38,
	quickUseItemList = 41,
	originalCostjp = 22,
	item = 32,
	offTag = 10,
	showLogoTag = 44,
	overviewJumpId = 45,
	country = 37,
	extraDiamond = 31,
	bigImg = 8,
	diamond = 29,
	product = 9,
	id = 1,
	currencyCodekr = 24,
	nameEn = 6,
	taskid = 43,
	detailDesc = 40,
	belongStoreId = 2,
	desc = 7,
	originalCost = 16,
	notShowInRecommend = 39,
	currencyCodetw = 27,
	order = 4,
	showLinkageTag = 42,
	isOnline = 11,
	originalCosttw = 28,
	offlineTime = 13,
	pricejp = 20,
	isShowTurnback = 46,
	currencyCode = 15,
	preGoodsId = 34
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	detailDesc = 2,
	name = 1
}

function lua_store_charge_goods.onLoad(json)
	lua_store_charge_goods.configList, lua_store_charge_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge_goods
