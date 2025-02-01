module("modules.configs.excel2json.lua_luckybag_summon_pool", package.seeall)

slot1 = {
	awardTime = 16,
	customClz = 11,
	advertising = 7,
	type = 3,
	upWeight = 15,
	priority = 2,
	initWeight = 14,
	desc = 6,
	nameCn = 4,
	characterDetail = 19,
	changeWeight = 17,
	jumpGroupId = 21,
	luckybagId = 22,
	cost1 = 12,
	historyShowType = 20,
	cost10 = 13,
	banner = 8,
	prefabPath = 10,
	bannerFlag = 9,
	id = 1,
	poolDetail = 18,
	actId = 23,
	nameEn = 5
}
slot2 = {
	"id"
}
slot3 = {
	nameCn = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
