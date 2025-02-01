module("modules.configs.excel2json.lua_investigate_clue", package.seeall)

slot1 = {
	mapRes = 5,
	relatedDesc = 9,
	infoID = 4,
	res = 6,
	mapElement = 3,
	id = 1,
	mapResLocked = 7,
	detailedDesc = 8,
	defaultUnlock = 2
}
slot2 = {
	"id"
}
slot3 = {
	detailedDesc = 1,
	relatedDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
