module("modules.configs.excel2json.lua_luckybag_summon_pool", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {
	nameCn = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
