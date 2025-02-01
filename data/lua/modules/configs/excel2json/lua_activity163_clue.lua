module("modules.configs.excel2json.lua_activity163_clue", package.seeall)

slot1 = {
	clueName = 3,
	materialId = 6,
	clueIcon = 2,
	clueId = 1,
	clueDesc = 4,
	replaceId = 7,
	episodeId = 5
}
slot2 = {
	"clueId"
}
slot3 = {
	clueName = 1,
	clueDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
