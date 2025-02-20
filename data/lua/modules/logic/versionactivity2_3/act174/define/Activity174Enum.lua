module("modules.logic.versionactivity2_3.act174.define.Activity174Enum", package.seeall)

slot0 = _M
slot0.GameState = {
	AfterFight = 4,
	Init = 1,
	BeforeFight = 3,
	ForceSelect = 999,
	Free = 2,
	EnterEndless = 998,
	None = 0
}
slot0.FightResult = {
	Win = 1,
	Lose = 2,
	Draw = 3,
	None = 0
}
slot0.BagType = {
	Collection = "collection",
	Enhance = "enhance",
	StartCareer = "startCareer",
	Endless = "endless",
	StartSpecial = "startSpecial",
	Hero = "hero",
	StartRare = "startRare"
}
slot0.WareType = {
	Collection = 2,
	Hero = 1
}
slot0.MaxWareItemSinglePage = 12
slot0.ConstKey = {
	BetHealth = 3,
	FreshRoundShopCost = 6,
	MatchTxt = 16,
	ChapterId = 8,
	InitHealth = 1,
	MatchWaitTime = 5,
	FightSpeed = 10,
	FreshShopCost = 4,
	ShopSlot = 2
}
slot0.PrefabPath = {
	BattleHero = "ui/viewres/versionactivity_2_3/act174/act174fightheroitem.prefab"
}
slot0.ItemTipType = {
	Character2 = 5,
	Buff = 3,
	Character1 = 4,
	Character3 = 6,
	Character = slot0.WareType.Hero,
	Collection = slot0.WareType.Collection
}
slot0.CollectionColor = {
	"587FA1",
	"8D6993",
	"B8945F"
}
slot0.heroBagIcon = {
	"act174_icon_1",
	"act174_icon_2",
	"act174_icon_3"
}
slot0.CharacterType = {
	Monster = "monster",
	Hero = "hero"
}
slot0.BadgeState = {
	Sp = 3,
	Light = 2,
	Normal = 1
}
slot0.EffectType = {
	Rebirth = 17,
	MaybeAddCoin = 18,
	BuyAddCoin = 3,
	AddHp = 5,
	DirectAddCoin = 1,
	DelayAddCoin = 2,
	EnhanceItem = 14,
	EnhanceRole = 11,
	ReduceHpAddCoin = 4
}

return slot0
