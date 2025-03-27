module("modules.configs.excel2json.lua_activity179_combo", package.seeall)

slot1 = {
	score = 4,
	combo = 3,
	resource = 5,
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
