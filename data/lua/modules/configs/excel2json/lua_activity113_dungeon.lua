module("modules.configs.excel2json.lua_activity113_dungeon", package.seeall)

slot1 = {
	openDay = 3,
	activityId = 2,
	chapterId = 1
}
slot2 = {
	"chapterId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
