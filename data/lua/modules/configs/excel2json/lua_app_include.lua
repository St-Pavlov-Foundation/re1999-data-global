module("modules.configs.excel2json.lua_app_include", package.seeall)

slot1 = {
	path = 8,
	video = 7,
	guide = 6,
	seasonIds = 5,
	roomTheme = 10,
	heroStoryIds = 11,
	story = 4,
	chapter = 3,
	character = 2,
	id = 1,
	maxWeekWalk = 9
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
