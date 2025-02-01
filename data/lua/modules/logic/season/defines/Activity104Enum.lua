module("modules.logic.season.defines.Activity104Enum", package.seeall)

slot0 = _M
slot0.SeasonChapterId = 1201
slot0.SeasonEpisodeId = 120101
slot0.SeasonType = {
	Season5 = 11500,
	Season2 = 11200,
	Season6 = 11600,
	Season1 = 11100,
	Season4 = 11400,
	Season3 = 11300
}
slot0.SeasonStore = {
	[slot0.SeasonType.Season1] = 11115,
	[slot0.SeasonType.Season2] = 11210,
	[slot0.SeasonType.Season3] = 11308,
	[slot0.SeasonType.Season4] = 11410,
	[slot0.SeasonType.Season5] = 11512,
	[slot0.SeasonType.Season6] = 11607
}
slot0.StoreUTTU = {
	[slot0.SeasonType.Season1] = 1112,
	[slot0.SeasonType.Season2] = 1212,
	[slot0.SeasonType.Season3] = 1312,
	[slot0.SeasonType.Season4] = 1412,
	[slot0.SeasonType.Season5] = 1512,
	[slot0.SeasonType.Season6] = 1612
}
slot0.SeasonViewPrefix = {
	[slot0.SeasonType.Season1] = "",
	[slot0.SeasonType.Season2] = "1_2",
	[slot0.SeasonType.Season3] = "1_3",
	[slot0.SeasonType.Season4] = "1_4",
	[slot0.SeasonType.Season5] = "1_5",
	[slot0.SeasonType.Season6] = "1_6"
}
slot0.SeasonIconFolder = {
	[slot0.SeasonType.Season3] = "v1a3_season",
	[slot0.SeasonType.Season4] = "v1a4_season",
	[slot0.SeasonType.Season5] = "v1a5_season",
	[slot0.SeasonType.Season6] = "v1a6_season"
}
slot0.CurSeasonId = slot0.SeasonType.Season6
slot0.BuffType = {
	Buff = 2,
	Debuff = 1
}
slot0.RuleTab = {
	Card = 2,
	Rule = 1
}
slot0.CareerType = {
	Shou = "4",
	Ling_Or_Zhi = "5",
	Xing = "2",
	Mu = "3",
	Yan = "1"
}
slot0.PlayerPrefsKeyItemUid = "Activity104ItemUid"
slot0.Rare_Orange = 4
slot0.MainRoleRare = 5
slot0.MainRoleHeadIconID = 300101
slot0.MainRoleSkinPath = "560501_vertin"
slot0.JumpId = {
	Market = 1,
	Discount = 3,
	Trail = 4,
	Retail = 2
}
slot0.ConstEnum = {
	RetailTicket = 1,
	ReadProcessLayer = 5,
	ReadProcessHead = 6,
	BlueToPurple = 2,
	GoldToOrange = 4,
	PurpleToGold = 3,
	LastSeasonId = 12,
	SumReviewCard = 14,
	SpecialOpenLayer = 8,
	SumMailLangKey = 15,
	SumReviewChapter = 13,
	SpecialOpenDayCount = 7,
	RuleTips = 11,
	RetailGuidePos = 10,
	SeasonOpenStorys = 9
}
slot0.ViewName = {
	RetailView = "RetailView",
	SettlementView = "SettlementView",
	CelebrityCardTipView = "CelebrityCardTipView",
	FightSuccView = "FightSuccView",
	MainView = "MainView",
	MarketView = "MarketView",
	HeroGroupFightView = "HeroGroupFightView",
	CelebrityCardGetlView = "CelebrityCardGetlView",
	FightFailView = "FightFailView",
	EquipHeroView = "EquipHeroView",
	EquipBookView = "EquipBookView",
	EquipSelfChoiceView = "EquipSelfChoiceView",
	StoreView = "StoreView",
	RetailLevelInfoView = "RetailLevelInfoView",
	SumView = "SumView",
	AdditionRuleTipView = "AdditionRuleTipView",
	EquipView = "EquipView",
	SpecialMarketView = "SpecialMarketView",
	FightRuleTipView = "FightRuleTipView",
	TaskView = "TaskView"
}

return slot0
