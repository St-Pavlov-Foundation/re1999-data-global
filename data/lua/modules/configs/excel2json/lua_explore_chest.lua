module("modules.configs.excel2json.lua_explore_chest", package.seeall)

slot1 = {
	bonus = 4,
	isCount = 5,
	chapterId = 3,
	id = 1,
	episodeId = 2
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
