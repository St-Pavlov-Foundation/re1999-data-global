module("modules.configs.excel2json.lua_auto_chess_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	preEpisode = 6,
	name = 3,
	firstBounds = 14,
	type = 5,
	winCondition = 11,
	image = 4,
	lostCondition = 12,
	functionOn = 16,
	mallIds = 9,
	maxRound = 10,
	masterLibraryId = 15,
	enemyId = 7,
	id = 2,
	masterId = 13,
	activityId = 1,
	npcEnemyId = 8
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
