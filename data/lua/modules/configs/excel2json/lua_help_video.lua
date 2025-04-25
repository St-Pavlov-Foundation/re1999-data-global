module("modules.configs.excel2json.lua_help_video", package.seeall)

slot1 = {
	text = 4,
	videopath = 2,
	storyId = 6,
	type = 3,
	id = 1,
	icon = 5,
	unlockGuideId = 7
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
