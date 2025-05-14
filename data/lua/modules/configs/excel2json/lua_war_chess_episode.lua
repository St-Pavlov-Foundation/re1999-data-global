module("modules.configs.excel2json.lua_war_chess_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	unlockSlotIds = 13,
	failCondition = 10,
	unlockChessSoldierIds = 12,
	presetSoldier = 18,
	extraWinConditionDesc = 7,
	presetCharacter = 17,
	preset = 16,
	winCondition = 6,
	strongHoldIds = 4,
	maxRound = 3,
	extraWinCondition = 8,
	unlockCharacterIds = 11,
	chessScene = 15,
	dialogueId = 19,
	eliminateScene = 14,
	failConditionDesc = 9,
	enemyId = 2,
	id = 1,
	winConditionDesc = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	extraWinConditionDesc = 2,
	winConditionDesc = 1,
	failConditionDesc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
