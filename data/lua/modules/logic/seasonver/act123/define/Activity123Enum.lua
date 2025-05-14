module("modules.logic.seasonver.act123.define.Activity123Enum", package.seeall)

local var_0_0 = _M

var_0_0.ActType = 123
var_0_0.EmptyUid = "0"
var_0_0.TestActivityID = 11700
var_0_0.TestActivityStage = 1
var_0_0.PickHeroCount = 8
var_0_0.SupportPosIndex = 8
var_0_0.HeroCardNum = 1
var_0_0.MainCardNum = 2
var_0_0.TaskNormalType = 0
var_0_0.TaskRewardViewType = 1
var_0_0.CardPackageSubType = 22
var_0_0.RecordItemCount = 6
var_0_0.DisplayMark = 1
var_0_0.SeasonChapterId = 1201
var_0_0.SeasonEpisodeId = 120101
var_0_0.SeasonStageStepCount = 5
var_0_0.PreCondition = {
	OpenTime = 2,
	StagePass = 1
}
var_0_0.PlayerPrefsKeyItemUid = "Activity123ItemUid"
var_0_0.MainCharPos = 4
var_0_0.MainRoleHeroUid = "main_role"
var_0_0.isMainRole = 1
var_0_0.MainRoleHeadIconID = 300101
var_0_0.openAllCardPackage = -1
var_0_0.maxDecomposeCount = 100
var_0_0.Const = {
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
var_0_0.JumpId = {
	ForStage = 5,
	Trail = 4,
	MarketNoResult = 6,
	Retail = 2,
	Market = 1,
	MarketStageFinish = 7
}
var_0_0.JumpType = {
	Stage = 1
}
var_0_0.CareerType = {
	Shou = "4",
	Ling_Or_Zhi = "5",
	Xing = "2",
	Mu = "3",
	Yan = "1"
}
var_0_0.AnimRecord = {
	UnlockTweenPos = "UnlockTweenPos"
}
var_0_0.SceneFolderPath = "_m_s15_sj"
var_0_0.DefaultBackgroundPrefab = "_m_s15_background_a"
var_0_0.StageSceneAnim = {
	Switch = "switch",
	Idle = "idle",
	Close = "close",
	Open = "open"
}
var_0_0.SeasonID = {
	Season5 = 12115,
	Season2 = 11811,
	Season6 = 12315,
	Season1 = 11700,
	Season4 = 12006,
	Season3 = 11906
}
var_0_0.SeasonIconFolder = {
	[var_0_0.SeasonID.Season1] = "v1a7_season_singlebg",
	[var_0_0.SeasonID.Season2] = "v1a8_season_singlebg",
	[var_0_0.SeasonID.Season3] = "v1a9_season_singlebg",
	[var_0_0.SeasonID.Season4] = "v2a0_season_singlebg",
	[var_0_0.SeasonID.Season5] = "v2a1_season_singlebg",
	[var_0_0.SeasonID.Season6] = "v2a3_season_singlebg"
}
var_0_0.RuleTab = {
	Card = 2,
	Rule = 1
}
var_0_0.TaskHardType = {
	Hard = 2,
	Normal = 1
}
var_0_0.SeasonViewPrefix = {
	[var_0_0.SeasonID.Season1] = "",
	[var_0_0.SeasonID.Season2] = "_1_8",
	[var_0_0.SeasonID.Season3] = "_1_9",
	[var_0_0.SeasonID.Season4] = "_2_0",
	[var_0_0.SeasonID.Season5] = "_2_1",
	[var_0_0.SeasonID.Season6] = "_2_3"
}
var_0_0.SeasonVersionPrefix = {
	[var_0_0.SeasonID.Season1] = "1_7",
	[var_0_0.SeasonID.Season2] = "1_8",
	[var_0_0.SeasonID.Season3] = "1_9",
	[var_0_0.SeasonID.Season4] = "2_0",
	[var_0_0.SeasonID.Season5] = "2_1",
	[var_0_0.SeasonID.Season6] = "2_3"
}
var_0_0.SeasonResourcePrefix = {
	[var_0_0.SeasonID.Season1] = "v1a7",
	[var_0_0.SeasonID.Season2] = "v1a8",
	[var_0_0.SeasonID.Season3] = "v1a9",
	[var_0_0.SeasonID.Season4] = "v2a0",
	[var_0_0.SeasonID.Season5] = "v2a1",
	[var_0_0.SeasonID.Season6] = "v2a3"
}
var_0_0.EquipCardEffect = {
	AddHeroGroupCardSlot = 104,
	ReduceRoundCount = 107
}

return var_0_0
