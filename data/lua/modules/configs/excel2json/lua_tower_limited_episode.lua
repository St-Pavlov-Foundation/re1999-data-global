module("modules.configs.excel2json.lua_tower_limited_episode", package.seeall)

slot1 = {
	entrance = 5,
	season = 3,
	layerId = 1,
	difficulty = 2,
	episodeId = 4
}
slot2 = {
	"layerId",
	"difficulty"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
