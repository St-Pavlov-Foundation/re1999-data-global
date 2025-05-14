module("modules.configs.excel2json.lua_store_recommend", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	systemJumpCode = 16,
	prefab = 4,
	relations = 14,
	adjustOrder = 8,
	name = 2,
	des = 6,
	className = 19,
	showOfflineTime = 13,
	onlineTime = 10,
	type = 17,
	topDay = 20,
	topType = 21,
	isOffline = 9,
	order = 7,
	isCustomLoad = 18,
	showOnlineTime = 12,
	offlineTime = 11,
	country = 15,
	res = 3,
	id = 1,
	nameEn = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	des = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
