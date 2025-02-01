module("modules.configs.excel2json.lua_activity114_travel", package.seeall)

slot1 = {
	specialEvents = 8,
	placeEn = 4,
	condition = 7,
	residentEvent = 6,
	id = 2,
	events = 5,
	activityId = 1,
	place = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	place = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
