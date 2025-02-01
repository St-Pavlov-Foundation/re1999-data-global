module("modules.configs.excel2json.lua_war_chess_episode", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {
	extraWinConditionDesc = 2,
	winConditionDesc = 1,
	failConditionDesc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
