module("modules.configs.excel2json.lua_activity107", package.seeall)

slot1 = {
	cost = 5,
	name = 8,
	tag = 6,
	maxBuyCount = 4,
	group = 12,
	order = 11,
	isOnline = 9,
	bigImg = 7,
	product = 3,
	id = 2,
	activityId = 1,
	preGoodsId = 10
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
