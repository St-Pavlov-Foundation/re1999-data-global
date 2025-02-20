module("modules.configs.excel2json.lua_store_recommend", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {
	des = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
