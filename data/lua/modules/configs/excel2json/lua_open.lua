module("modules.configs.excel2json.lua_open", package.seeall)

slot1 = {
	isOnline = 3,
	name = 2,
	verifingHide = 11,
	verifingEpisodeId = 7,
	roomLevel = 13,
	playerLv = 4,
	episodeId = 5,
	elementId = 6,
	isAlwaysShowBtn = 8,
	bindActivityId = 12,
	id = 1,
	showInEpisode = 9,
	dec = 10
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
