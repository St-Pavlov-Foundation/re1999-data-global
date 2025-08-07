module("modules.logic.sp01.act205.define.Act205Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActId = ActivityEnum.Activity.V2a9_Act205
var_0_0.GameStageId = {
	Ocean = 2,
	Chase = 3,
	Card = 1
}
var_0_0.ConstId = {
	CardGameEnemyCardCount = 9,
	CardGamePlayerCardCount = 8,
	MinimumGuaranteeCard = 10,
	OceanGameAddWinWeight = 6,
	CardGameBasePoint = 7,
	OceanGameFailTimesToWin = 5
}
var_0_0.CardGameFailPoint = 1
var_0_0.CardGameCacheDataPrefsKey = "Act205CardGameCacheDataKey"
var_0_0.SpEffType = {
	All = 1,
	Half = 2
}
var_0_0.CardType = {
	Role = 1,
	Weapon = 2
}
var_0_0.CardPKResult = {
	BeRestrained = -1,
	Draw = 0,
	Restrain = 1
}
var_0_0.CardGameCacheKey = {
	PlayerCard = "Act205CardGamePlayerCard",
	EnemyCard = "Act205CardGameEnemyCard"
}
var_0_0.saveLocalOceanGoldKey = "Act205OceanGameGold"
var_0_0.saveLocalOceanDiceKey = "Act205OceanGameDice"
var_0_0.oceanGoldHardType = {
	Hard = 2,
	Normal = 1
}
var_0_0.oceanDiceMaxCount = 3

return var_0_0
