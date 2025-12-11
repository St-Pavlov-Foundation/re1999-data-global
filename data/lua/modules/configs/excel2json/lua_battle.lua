module("modules.configs.excel2json.lua_battle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	restrictReason = 28,
	trialMainAct104EuqipId = 32,
	battleEffectiveness = 23,
	noClothSkill = 8,
	fightDec = 22,
	talentEffectiveness = 26,
	monsterMax = 10,
	useTemp = 18,
	clothSkill = 17,
	maxRound = 11,
	bossHpType = 38,
	noAutoFight = 35,
	sceneIds = 3,
	additionRule = 15,
	balance = 33,
	actionRule = 34,
	heroEffectiveness = 24,
	winCondition = 12,
	myStance = 16,
	playerMax = 9,
	fightTitle = 21,
	aiLink = 37,
	bgmevent = 20,
	id = 1,
	dialogParam = 19,
	trialHeros = 29,
	equipEffectiveness = 25,
	monsterGroupIds = 2,
	previewSkinId = 5,
	restrictRoles = 27,
	roleNum = 6,
	trialLimit = 30,
	hiddenRule = 14,
	advancedCondition = 13,
	focusMonsterId = 4,
	aid = 7,
	onlyTrial = 36,
	trialEquips = 31
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	restrictReason = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
