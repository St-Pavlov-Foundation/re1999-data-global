module("modules.configs.excel2json.lua_season_episode", package.seeall)

slot1 = {
	buffName = 6,
	name = 3,
	desc = 7,
	waveScoreRate = 9,
	openDate = 4,
	seasonEpisodeId = 2,
	id = 1,
	icon = 8,
	gradeCondition = 5
}
slot2 = {
	"id",
	"seasonEpisodeId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
