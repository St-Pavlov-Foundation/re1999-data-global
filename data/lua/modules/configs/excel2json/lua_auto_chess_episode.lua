module("modules.configs.excel2json.lua_auto_chess_episode", package.seeall)

slot1 = {
	preEpisode = 6,
	name = 2,
	firstBounds = 14,
	type = 4,
	winCondition = 11,
	image = 3,
	lostCondition = 12,
	masterId = 13,
	mallIds = 9,
	maxRound = 10,
	enemyId = 7,
	id = 1,
	activityId = 5,
	npcEnemyId = 8
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
