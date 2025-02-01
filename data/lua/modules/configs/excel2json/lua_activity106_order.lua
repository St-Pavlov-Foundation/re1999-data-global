module("modules.configs.excel2json.lua_activity106_order", package.seeall)

slot1 = {
	gameSetting = 14,
	name = 4,
	titledesc = 5,
	openDay = 11,
	infoDesc = 17,
	desc = 6,
	listenerParam = 9,
	maxProgress = 10,
	activityId = 1,
	order = 15,
	jumpId = 16,
	location = 7,
	rare = 3,
	listenerType = 8,
	id = 2,
	bossPic = 13,
	bonus = 12
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1,
	location = 4,
	titledesc = 2,
	infoDesc = 5,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
