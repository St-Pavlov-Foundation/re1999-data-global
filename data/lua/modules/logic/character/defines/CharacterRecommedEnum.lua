module("modules.logic.character.defines.CharacterRecommedEnum", package.seeall)

local var_0_0 = _M

var_0_0.TabSubType = {
	DevelopGoals = 2,
	RecommedGroup = 1
}
var_0_0.DevelopGoalsType = {
	RankLevel = 1,
	TalentLevel = 2
}
var_0_0.JumpView = {
	Level = 2,
	Rank = 1,
	Dungeon = 3
}
var_0_0.ResDungeon = {
	[DungeonEnum.ChapterId.ResourceExp] = {
		UnlockFunc = OpenEnum.UnlockFunc.GoldDungeon
	},
	[DungeonEnum.ChapterId.ResourceGold] = {
		UnlockFunc = OpenEnum.UnlockFunc.ExperienceDungeon
	},
	[DungeonEnum.ChapterId.EquipDungeonChapterId] = {
		UnlockFunc = OpenEnum.UnlockFunc.EquipDungeon
	},
	[DungeonEnum.ChapterId.HarvestDungeonChapterId] = {
		UnlockFunc = OpenEnum.UnlockFunc.Buildings
	}
}
var_0_0.RankResDungeon = {
	DungeonEnum.ChapterId.InsightMountain,
	DungeonEnum.ChapterId.InsightStarfall,
	DungeonEnum.ChapterId.InsightSylvanus,
	DungeonEnum.ChapterId.InsightBrutes
}
var_0_0.AnimName = {
	Switch = "switch",
	Close = "close",
	Open = "open"
}
var_0_0.TracedIconPath = "ui/viewres/character/recommed/traceitem.prefab"
var_0_0.TraceHeroPref = "CharacterRecommedEnum_TraceHeroPref_"

return var_0_0
