module("modules.configs.excel2json.lua_explore_scene", package.seeall)

slot1 = {
	sceneId = 4,
	signsId = 5,
	chapterId = 1,
	id = 3,
	episodeId = 2
}
slot2 = {
	"chapterId",
	"episodeId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
