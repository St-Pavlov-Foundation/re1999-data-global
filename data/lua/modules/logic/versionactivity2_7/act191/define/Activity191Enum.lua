module("modules.logic.versionactivity2_7.act191.define.Activity191Enum", package.seeall)

local var_0_0 = _M

var_0_0.NodeType = {
	MonsterBattle6 = 16,
	PlayerBattle2 = 12,
	MonsterBattle5 = 15,
	PlayerBattle5 = 18,
	RoleShop = 2,
	PlayerBattle6 = 19,
	Enhance = 7,
	CollectionShop = 3,
	MonsterBattle2 = 9,
	MonsterBattle7 = 21,
	MonsterBattle1 = 8,
	MonsterBattle4 = 14,
	PlayerBattle1 = 11,
	MonsterBattle3 = 10,
	PlayerBattle7 = 20,
	MixStore = 1,
	RewardEvent = 5,
	PlayerBattle4 = 17,
	PlayerBattle3 = 13,
	BattleEvent = 6,
	TagShop = 4
}
var_0_0.NodeType2Key = {
	[var_0_0.NodeType.PlayerBattle1] = "playerBattle1",
	[var_0_0.NodeType.PlayerBattle2] = "playerBattle2",
	[var_0_0.NodeType.PlayerBattle3] = "playerBattle3",
	[var_0_0.NodeType.PlayerBattle4] = "playerBattle4",
	[var_0_0.NodeType.PlayerBattle5] = "playerBattle5",
	[var_0_0.NodeType.PlayerBattle6] = "playerBattle6",
	[var_0_0.NodeType.PlayerBattle7] = "playerBattle7"
}
var_0_0.EffectType = {
	ItemByItem = 7,
	CountEffects = 11,
	DelayEffect = 10,
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
	21
}
var_0_0.PvpFiled = {
	11,
	12,
	13,
	17,
	18,
	19,
	20
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
	RoleTag = 10,
	EnhanceDesc = 9,
	PvpEpisodeName = 18,
	PlayerMaxScore = 7,
	CollectionTag = 11,
	CharacterUpExp = 4,
	MaxFreshNum = 13,
	FightSpeed = 27,
	FetterTag = 12,
	TagShopFreshLimit = 29,
	ShopFreshCost = 1,
	EnhanceTitle = 8,
	TagShopFreshCost = 28,
	PvpBattleEpisodeId = 6
}
var_0_0.CharacterType = {
	Monster = "monster",
	Hero = "hero"
}
var_0_0.CollectionColor = {
	"587FA1",
	"8D6993",
	"B8945F"
}
var_0_0.CharacterMaxStar = 6
var_0_0.OpTeamType = {
	ChangeName = 2,
	ChangeIndex = 3,
	Normal = 1
}
var_0_0.SortRule = {
	Down = 2,
	Up = 1
}
var_0_0.HyperLinkPattern = {
	EnhanceDestiny = "「(.-)」",
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

return var_0_0
