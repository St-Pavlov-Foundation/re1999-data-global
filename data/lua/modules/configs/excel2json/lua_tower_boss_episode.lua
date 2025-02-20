module("modules.configs.excel2json.lua_tower_boss_episode", package.seeall)

slot1 = {
	layerId = 2,
	firstReward = 7,
	bossLevel = 6,
	preLayerId = 3,
	episodeId = 5,
	openRound = 4,
	towerId = 1
}
slot2 = {
	"towerId",
	"layerId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
