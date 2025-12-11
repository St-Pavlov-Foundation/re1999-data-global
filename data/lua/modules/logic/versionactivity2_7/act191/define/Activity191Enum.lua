module("modules.logic.versionactivity2_7.act191.define.Activity191Enum", package.seeall)

local var_0_0 = _M

var_0_0.MaxItemLevel = 4
var_0_0.NodeType = {
	PlayerBattle8 = 27,
	MonsterBattle3 = 10,
	MonsterBattle8 = 22,
	PlayerBattle10 = 29,
	PlayerBattle5 = 18,
	MonsterBattle2 = 9,
	MonsterBattle7 = 21,
	CollectionShop = 3,
	MonsterBattle10 = 24,
	MonsterBattle5 = 15,
	MonsterBattle1 = 8,
	PlayerBattle12 = 31,
	MixStore = 1,
	PlayerBattle4 = 17,
	BattleEvent = 6,
	MonsterBattle12 = 26,
	MonsterBattle6 = 16,
	PlayerBattle6 = 19,
	RoleShop = 2,
	Enhance = 7,
	PlayerBattle2 = 12,
	MonsterBattle4 = 14,
	PlayerBattle1 = 11,
	MonsterBattle11 = 25,
	PlayerBattle7 = 20,
	ReplaceEvent = 101,
	UpgradeEvent = 102,
	RewardEvent = 5,
	PlayerBattle11 = 30,
	PlayerBattle3 = 13,
	MonsterBattle9 = 23,
	PlayerBattle9 = 28,
	TagShop = 4
}
var_0_0.NodeType2Key = {
	[var_0_0.NodeType.PlayerBattle1] = "playerBattle1",
	[var_0_0.NodeType.PlayerBattle2] = "playerBattle2",
	[var_0_0.NodeType.PlayerBattle3] = "playerBattle3",
	[var_0_0.NodeType.PlayerBattle4] = "playerBattle4",
	[var_0_0.NodeType.PlayerBattle5] = "playerBattle5",
	[var_0_0.NodeType.PlayerBattle6] = "playerBattle6",
	[var_0_0.NodeType.PlayerBattle7] = "playerBattle7",
	[var_0_0.NodeType.PlayerBattle8] = "playerBattle8",
	[var_0_0.NodeType.PlayerBattle9] = "playerBattle9",
	[var_0_0.NodeType.PlayerBattle10] = "playerBattle10",
	[var_0_0.NodeType.PlayerBattle11] = "playerBattle11",
	[var_0_0.NodeType.PlayerBattle12] = "playerBattle12"
}
var_0_0.EffectType = {
	ItemByItem = 7,
	CountEffects = 11,
	DelayEffect = 10,
	ExtraFetter = 18,
	AttrEffect = 19,
	EnhanceHero = 8,
	HeroByTag = 3,
	ItemByTag = 6,
	Money = 1,
	Item = 5,
	EnhanceItem = 9,
	HeroByHero = 4,
	Hero = 2
}
var_0_0.PveFiled = {
	8,
	9,
	10,
	14,
	15,
	16,
	21,
	22,
	23,
	24,
	25,
	26
}
var_0_0.PvpFiled = {
	11,
	12,
	13,
	17,
	18,
	19,
	20,
	27,
	28,
	29,
	30,
	31
}
var_0_0.TagShopField = {
	4
}
var_0_0.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Mdefense
}
var_0_0.GameState = {
	Normal = 1,
	End = -1,
	None = 0
}
var_0_0.ConstKey = {
	EnhanceTitle = 8,
	CollectionTag = 11,
	PvpEpisodeName = 18,
	PlayerMaxScore = 7,
	EnhanceDesc = 9,
	ReplaceTitle = 42,
	ReplaceTag = 40,
	FightSpeed = 27,
	UpgradeDesc = 45,
	ShopFreshCost = 1,
	TagShopFreshCost = 28,
	PvpBattleEpisodeId = 6,
	ReplaceMaxCnt = 38,
	RoleTag = 10,
	ReplaceDesc = 44,
	MaxFreshNum = 13,
	CharacterUpExp = 4,
	FetterTag = 12,
	TagShopFreshLimit = 29,
	UpgradeTitle = 43,
	UpgradeMaxCnt = 39,
	UpgradeTag = 41
}
var_0_0.CharacterType = {
	Monster = "monster",
	Hero = "hero"
}
var_0_0.CollectionColor = {
	"587FA1",
	"8D6993",
	"B8945F",
	"BD5900"
}
var_0_0.CharacterMaxStar = 6
var_0_0.SortRule = {
	Down = 2,
	Up = 1
}
var_0_0.HyperLinkPattern = {
	EnhanceDestiny = "「(.-)」",
	Hero = "《(.-)》",
	SkillDesc = "﹝(.-)﹞",
	EnhanceItem = "『(.-)』"
}
var_0_0.PrefabPath = {
	HeroHeadItem = "ui/viewres/versionactivity_2_7/act191/item/act191heroheaditem.prefab",
	FetterItem = "ui/viewres/versionactivity_2_7/act191/item/act191fetteritem.prefab",
	CollectionItem = "ui/viewres/versionactivity_2_7/act191/item/act191collectionitem.prefab",
	NodeListItem = "ui/viewres/versionactivity_2_7/act191/item/act191nodelistitem.prefab",
	BossHpItem = "ui/viewres/fight/fight_act191bosshpview.prefab",
	HeroEditItem = "ui/viewres/versionactivity_2_7/act191/item/act191heroedititem.prefab",
	TeamComp = "ui/viewres/versionactivity_2_7/act191/item/act191teamitem.prefab",
	RewardItem = "ui/viewres/versionactivity_2_7/act191/item/act191rewarditem.prefab"
}
var_0_0.InitBuildType = {
	Random = 2,
	Extra = 3,
	Normal = 1
}
var_0_0.SummonType = {
	Monster = 2,
	Boss = 1
}

return var_0_0
