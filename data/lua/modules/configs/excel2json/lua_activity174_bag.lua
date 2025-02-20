module("modules.configs.excel2json.lua_activity174_bag", package.seeall)

slot1 = {
	season = 3,
	bagDesc = 8,
	costCoin = 6,
	type = 4,
	heroNum = 11,
	heroParam = 10,
	collectionType = 12,
	activityId = 2,
	collectionNum = 14,
	quality = 5,
	heroType = 9,
	enhanceNum = 17,
	collectionParam = 13,
	enhanceType = 15,
	id = 1,
	bagTitle = 7,
	enhanceParam = 16
}
slot2 = {
	"id"
}
slot3 = {
	bagDesc = 2,
	bagTitle = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
