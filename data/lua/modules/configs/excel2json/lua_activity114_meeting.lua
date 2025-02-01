module("modules.configs.excel2json.lua_activity114_meeting", package.seeall)

slot1 = {
	nameEng = 4,
	name = 3,
	banTurn = 10,
	tag = 11,
	events = 7,
	condition = 8,
	character = 6,
	id = 2,
	signature = 5,
	activityId = 1,
	des = 9
}
slot2 = {
	"activityId",
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
