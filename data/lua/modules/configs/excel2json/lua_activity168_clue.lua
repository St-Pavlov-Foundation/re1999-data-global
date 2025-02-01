module("modules.configs.excel2json.lua_activity168_clue", package.seeall)

slot1 = {
	infoID = 6,
	mapElement = 5,
	desc = 3,
	clueId = 1,
	related = 7,
	icon = 2,
	defaultUnlock = 4
}
slot2 = {
	"clueId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
