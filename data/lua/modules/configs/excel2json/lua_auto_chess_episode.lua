module("modules.configs.excel2json.lua_auto_chess_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
