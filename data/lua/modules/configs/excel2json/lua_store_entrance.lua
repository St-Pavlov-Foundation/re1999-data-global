module("modules.configs.excel2json.lua_store_entrance", package.seeall)

slot1 = {
	name = 4,
	prefab = 6,
	nameEn = 5,
	openId = 10,
	activityId = 11,
	openTime = 12,
	belongFirstTab = 2,
	belongSecondTab = 3,
	storeId = 14,
	openHideId = 15,
	endTime = 13,
	id = 1,
	icon = 7,
	showCost = 9,
	order = 8
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
