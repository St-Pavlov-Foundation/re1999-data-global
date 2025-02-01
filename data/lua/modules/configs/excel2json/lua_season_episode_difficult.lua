module("modules.configs.excel2json.lua_season_episode_difficult", package.seeall)

slot1 = {
	id = 1,
	buffPool = 10,
	recommendLevel = 5,
	unlockDesc = 9,
	multiple = 6,
	ponitCondition = 11,
	seasonEpisodeId = 2,
	battleId = 4,
	difficult = 3,
	unlockDifficult = 7,
	unlockScore = 8
}
slot2 = {
	"id",
	"seasonEpisodeId",
	"difficult"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
