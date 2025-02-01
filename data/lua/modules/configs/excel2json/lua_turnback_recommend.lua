module("modules.configs.excel2json.lua_turnback_recommend", package.seeall)

slot1 = {
	jumpId = 10,
	limitCount = 12,
	turnbackId = 1,
	relateActId = 11,
	prepose = 5,
	offlineTime = 8,
	constTime = 6,
	openId = 9,
	onlineTime = 7,
	id = 2,
	icon = 3,
	order = 4
}
slot2 = {
	"turnbackId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
