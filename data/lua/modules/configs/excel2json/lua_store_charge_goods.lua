module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
	currencyCode = 15,
	preGoodsId = 34
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	detailDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
