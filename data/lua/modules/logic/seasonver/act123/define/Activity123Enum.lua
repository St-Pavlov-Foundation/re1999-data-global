module("modules.logic.seasonver.act123.define.Activity123Enum", package.seeall)

slot0 = _M
slot0.ActType = 123
slot0.EmptyUid = "0"
slot0.TestActivityID = 11700
slot0.TestActivityStage = 1
slot0.PickHeroCount = 8
slot0.SupportPosIndex = 8
slot0.HeroCardNum = 1
slot0.MainCardNum = 2
slot0.TaskNormalType = 0
slot0.TaskRewardViewType = 1
slot0.CardPackageSubType = 22
slot0.RecordItemCount = 6
slot0.DisplayMark = 1
slot0.SeasonChapterId = 1201
slot0.SeasonEpisodeId = 120101
slot0.SeasonStageStepCount = 5
slot0.PreCondition = {
	OpenTime = 2,
	StagePass = 1
}
slot0.PlayerPrefsKeyItemUid = "Activity123ItemUid"
slot0.MainCharPos = 4
slot0.MainRoleHeroUid = "main_role"
slot0.isMainRole = 1
slot0.MainRoleHeadIconID = 300101
slot0.openAllCardPackage = -1
slot0.maxDecomposeCount = 100
slot0.Const = {
	StoryCoverTitle = 9,
	UttuTicketsCoin = 1,
	StoryCoverIconUrl = 3,
	HideRule = 10,
	EquipItemCoin = 2,
	StoryCoverDesc = 4,
	RetailOpenStage = 5,
	StoreActId = 7,
	StoreCoinId = 6
}
slot0.JumpId = {
	ForStage = 5,
	Trail = 4,
	MarketNoResult = 6,
	Retail = 2,
	Market = 1,
	MarketStageFinish = 7
}
slot0.JumpType = {
	Stage = 1
}
slot0.CareerType = {
	Shou = "4",
	Ling_Or_Zhi = "5",
	Xing = "2",
	Mu = "3",
	Yan = "1"
}
slot0.AnimRecord = {
	UnlockTweenPos = "UnlockTweenPos"
}
slot0.SceneFolderPath = "_m_s15_sj"
slot0.DefaultBackgroundPrefab = "_m_s15_background_a"
slot0.StageSceneAnim = {
	Switch = "switch",
	Idle = "idle",
	Close = "close",
	Open = "open"
}
slot0.SeasonID = {
	Season5 = 12115,
	Season2 = 11811,
	Season6 = 12315,
	Season1 = 11700,
	Season4 = 12006,
	Season3 = 11906
}
slot0.SeasonIconFolder = {
	[slot0.SeasonID.Season1] = "v1a7_season_singlebg",
	[slot0.SeasonID.Season2] = "v1a8_season_singlebg",
	[slot0.SeasonID.Season3] = "v1a9_season_singlebg",
	[slot0.SeasonID.Season4] = "v2a0_season_singlebg",
	[slot0.SeasonID.Season5] = "v2a1_season_singlebg",
	[slot0.SeasonID.Season6] = "v2a3_season_singlebg"
}
slot0.RuleTab = {
	Card = 2,
	Rule = 1
}
slot0.TaskHardType = {
	Hard = 2,
	Normal = 1
}
slot0.SeasonViewPrefix = {
	[slot0.SeasonID.Season1] = "",
	[slot0.SeasonID.Season2] = "_1_8",
	[slot0.SeasonID.Season3] = "_1_9",
	[slot0.SeasonID.Season4] = "_2_0",
	[slot0.SeasonID.Season5] = "_2_1",
	[slot0.SeasonID.Season6] = "_2_3"
}
slot0.SeasonVersionPrefix = {
	[slot0.SeasonID.Season1] = "1_7",
	[slot0.SeasonID.Season2] = "1_8",
	[slot0.SeasonID.Season3] = "1_9",
	[slot0.SeasonID.Season4] = "2_0",
	[slot0.SeasonID.Season5] = "2_1",
	[slot0.SeasonID.Season6] = "2_3"
}
slot0.SeasonResourcePrefix = {
	[slot0.SeasonID.Season1] = "v1a7",
	[slot0.SeasonID.Season2] = "v1a8",
	[slot0.SeasonID.Season3] = "v1a9",
	[slot0.SeasonID.Season4] = "v2a0",
	[slot0.SeasonID.Season5] = "v2a1",
	[slot0.SeasonID.Season6] = "v2a3"
}
slot0.EquipCardEffect = {
	AddHeroGroupCardSlot = 104,
	ReduceRoundCount = 107
}

return slot0
