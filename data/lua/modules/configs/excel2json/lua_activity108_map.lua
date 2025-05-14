module("modules.configs.excel2json.lua_activity108_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cookie = 16,
	actContent = 13,
	endContent = 18,
	threat = 7,
	cookieContent = 17,
	title = 11,
	content = 12,
	offlineDay = 6,
	exhibits = 8,
	monsterIcon = 9,
	enemyTitle = 14,
	activityId = 4,
	enemyInfo = 15,
	preId = 2,
	onlineDay = 5,
	id = 1,
	consignor = 10,
	initScore = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 2,
	cookieContent = 7,
	actContent = 4,
	endContent = 8,
	enemyTitle = 5,
	consignor = 1,
	content = 3,
	enemyInfo = 6
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
