module("modules.configs.excel2json.lua_activity117_order", package.seeall)

slot1 = {
	openDay = 4,
	name = 3,
	maxAcceptScore = 7,
	minDealScore = 6,
	jumpId = 12,
	maxDealScore = 8,
	listenerType = 9,
	listenerParam = 10,
	id = 2,
	maxProgress = 11,
	activityId = 1,
	order = 5
}
slot2 = {
	"activityId",
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
