module("modules.logic.season.defines.Activity104Enum", package.seeall)

local var_0_0 = _M

var_0_0.SeasonChapterId = 1201
var_0_0.SeasonEpisodeId = 120101
var_0_0.SeasonType = {
	Season5 = 11500,
	Season2 = 11200,
	Season6 = 11600,
	Season1 = 11100,
	SeasonV3A0 = 13000,
	Season4 = 11400,
	Season3 = 11300
}
var_0_0.SeasonStore = {
	[var_0_0.SeasonType.Season1] = 11115,
	[var_0_0.SeasonType.Season2] = 11210,
	[var_0_0.SeasonType.Season3] = 11308,
	[var_0_0.SeasonType.Season4] = 11410,
	[var_0_0.SeasonType.Season5] = 11512,
	[var_0_0.SeasonType.Season6] = 11607,
	[var_0_0.SeasonType.SeasonV3A0] = 13003
}
var_0_0.StoreUTTU = {
	[var_0_0.SeasonType.Season1] = 1112,
	[var_0_0.SeasonType.Season2] = 1212,
	[var_0_0.SeasonType.Season3] = 1312,
	[var_0_0.SeasonType.Season4] = 1412,
	[var_0_0.SeasonType.Season5] = 1512,
	[var_0_0.SeasonType.Season6] = 1612,
	[var_0_0.SeasonType.SeasonV3A0] = 3012
}
var_0_0.SeasonViewPrefix = {
	[var_0_0.SeasonType.Season1] = "",
	[var_0_0.SeasonType.Season2] = "1_2",
	[var_0_0.SeasonType.Season3] = "1_3",
	[var_0_0.SeasonType.Season4] = "1_4",
	[var_0_0.SeasonType.Season5] = "1_5",
	[var_0_0.SeasonType.Season6] = "1_6",
	[var_0_0.SeasonType.SeasonV3A0] = "3_0"
}
var_0_0.SeasonIconFolder = {
	[var_0_0.SeasonType.Season3] = "v1a3_season",
	[var_0_0.SeasonType.Season4] = "v1a4_season",
	[var_0_0.SeasonType.Season5] = "v1a5_season",
	[var_0_0.SeasonType.Season6] = "v1a6_season",
	[var_0_0.SeasonType.SeasonV3A0] = "v3a0_season"
}
var_0_0.CurSeasonId = var_0_0.SeasonType.SeasonV3A0
var_0_0.BuffType = {
	Buff = 2,
	Debuff = 1
}
var_0_0.RuleTab = {
	Card = 2,
	Rule = 1
}
var_0_0.CareerType = {
	Shou = "4",
	Ling_Or_Zhi = "5",
	Xing = "2",
	Mu = "3",
	Yan = "1"
}
var_0_0.PlayerPrefsKeyItemUid = "Activity104ItemUid"
var_0_0.Rare_Orange = 4
var_0_0.MainRoleRare = 5
var_0_0.MainRoleHeadIconID = 300101
var_0_0.MainRoleSkinPath = "560501_vertin"
var_0_0.JumpId = {
	Market = 1,
	Discount = 3,
	Trail = 4,
	Retail = 2
}
var_0_0.ConstEnum = {
	BlueToPurple = 2,
	LastSeasonId = 12,
	ReadProcessHead = 6,
	ReadProcessLayer = 5,
	StoryCoverIconUrl = 16,
	RetailTicket = 1,
	SumMailLangKey = 15,
	SumReviewChapter = 13,
	StoryCoverTitle = 18,
	PurpleToGold = 3,
	GoldToOrange = 4,
	StoryCoverDesc = 17,
	SumReviewCard = 14,
	SpecialOpenLayer = 8,
	SpecialOpenDayCount = 7,
	RuleTips = 11,
	RetailGuidePos = 10,
	SeasonOpenStorys = 9
}
var_0_0.ViewName = {
	RetailView = "RetailView",
	SettlementView = "SettlementView",
	CelebrityCardTipView = "CelebrityCardTipView",
	FightSuccView = "FightSuccView",
	MainView = "MainView",
	MarketView = "MarketView",
	HeroGroupFightView = "HeroGroupFightView",
	CelebrityCardGetlView = "CelebrityCardGetlView",
	FightFailView = "FightFailView",
	StoryView = "StoryView",
	EquipHeroView = "EquipHeroView",
	EquipBookView = "EquipBookView",
	EquipSelfChoiceView = "EquipSelfChoiceView",
	StoryPagePopView = "StoryPagePopView",
	StoreView = "StoreView",
	RetailLevelInfoView = "RetailLevelInfoView",
	SumView = "SumView",
	AdditionRuleTipView = "AdditionRuleTipView",
	EquipView = "EquipView",
	SpecialMarketView = "SpecialMarketView",
	FightRuleTipView = "FightRuleTipView",
	TaskView = "TaskView"
}

return var_0_0
