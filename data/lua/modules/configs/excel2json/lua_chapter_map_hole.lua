module("modules.configs.excel2json.lua_chapter_map_hole", package.seeall)

slot1 = {
	param = 3,
	mapId = 1,
	sort = 2
}
slot2 = {
	"mapId",
	"sort"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
