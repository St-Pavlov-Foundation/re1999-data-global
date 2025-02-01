module("modules.configs.excel2json.lua_activity147_goods", package.seeall)

slot1 = {
	cost = 4,
	maxBuyCount = 5,
	product = 3,
	type = 6,
	id = 2,
	activityId = 1
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
