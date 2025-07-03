module("modules.logic.versionactivity2_7.lengzhou6.define.LengZhou6Enum", package.seeall)

local var_0_0 = class("LengZhou6Enum")

var_0_0.entityCamp = {
	enemy = 2,
	player = 1
}
var_0_0.TaskMOAllFinishId = -99999
var_0_0.SkillType = {
	passive = "passive",
	enemyActive = "enemyActive",
	active = "active"
}
var_0_0.BattleStep = {
	attackAfter = 208,
	attackComplete = 212,
	enemyCheckInterval = 900,
	attackBefore = 201,
	gameEnd = 1000,
	addBuff = 109,
	calHpBefore = 101,
	calHpAfter = 108,
	poisonSettlement = 910,
	gameBegin = 0
}
var_0_0.LoadingTime = 1
var_0_0.SkillEffect = {
	AddBuffByIntensified = "AddBuffByIntensified",
	EliminationDecreaseCd = "EliminationDecreaseCd",
	DealsDamage = "DealsDamage",
	DamageUpByIntensified = "DamageUpByIntensified",
	Heal = "Heal",
	AddBuff = "AddBuff",
	EliminationLevelUp = "EliminationLevelUp",
	Shuffle = "Shuffle",
	Contaminate = "Contaminate",
	HealUpByIntensified = "HealUpByIntensified",
	PetrifyEliminationBlock = "PetrifyEliminationBlock",
	EliminationCross = "EliminationCross",
	EliminationRange = "EliminationRange",
	EliminationDoubleAttack = "EliminationDoubleAttack",
	FreezeEliminationBlock = "FreezeEliminationBlock",
	SuccessiveElimination = "SuccessiveElimination",
	DamageUpByType = "DamageUpByType"
}
var_0_0.NormalEliminateEffect = "normal"
var_0_0.BuffEffect = {
	damageUp = "damageUp",
	petrify = "petrify",
	poison = "poison"
}
var_0_0.BattleModel = {
	infinite = "infinite",
	normal = "normal"
}
var_0_0.BattleProgress = {
	selectFinish = 2,
	selectSkill = 1
}
var_0_0.EnemySkillTime = 1
var_0_0.EnemySkillTime_2 = 0.5
var_0_0.EnemyBuffEffectShowTime = 0.5
var_0_0.enterGM = false
var_0_0.DebugPlayerHp = 10000000
var_0_0.PlayerSkillMaxCount = 3
var_0_0.DefaultEndLessBeginRound = 1
var_0_0.EndLessChangeSkillLayer = 5
var_0_0.BlockKey = {
	OneClickResetLevel = "LengZhou6OneClickResetLevelKey",
	OneClickClaimReward = "LengZhou6OneClickClaimRewardBlockKey"
}
var_0_0.openViewAniTime = 1.167
var_0_0.GameResult = {
	normalCancel = 3,
	lose = 2,
	infiniteCancel = 4,
	win = 1
}
var_0_0.defaultEnemy = 227101
var_0_0.defaultPlayerSkillSelectMax = 3

return var_0_0
