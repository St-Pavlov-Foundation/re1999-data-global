module("modules.configs.excel2json.lua_room_order_refresh", package.seeall)

slot1 = {
	wholesaleRevenueWeeklyLimit = 5,
	finishLimitDaily = 3,
	wholesaleGoodsWeight = 6,
	meanwhileWholesaleNum = 4,
	qualityWeight = 2,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
