module("modules.configs.excel2json.lua_activity124_episode", package.seeall)

slot1 = {
	openDay = 4,
	name = 6,
	firstBonus = 5,
	mapId = 7,
	preEpisode = 3,
	activityId = 1,
	episodeId = 2
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
