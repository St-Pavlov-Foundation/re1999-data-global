module("modules.configs.excel2json.lua_activity155_drop", package.seeall)

slot1 = {
	itemId1 = 4,
	itemId2 = 5,
	chapterId = 3,
	id = 1,
	activityId = 2
}
slot2 = {
	"id",
	"activityId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
