module("modules.configs.excel2json.lua_store_goods", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {
	offTag = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
