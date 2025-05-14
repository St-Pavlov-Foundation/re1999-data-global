module("modules.logic.versionactivity1_6.v1a6_cachot.define.V1a6_CachotEnum", package.seeall)

local var_0_0 = _M

var_0_0.EventType = {
	Battle = 1,
	CollectionSelect = 9,
	CharacterCure = 5,
	Random = 3,
	Tip = 11,
	HeroPosUpgrade = 10,
	Store = 4,
	CharacterRebirth = 6,
	ChoiceSelect = 2,
	CharacterGet = 7,
	Empty = 8
}
var_0_0.NoLimit = "3"
var_0_0.HeroCountInGroup = 4
var_0_0.MaxHeroCountInGroup = 4
var_0_0.InitTeamMaxHeroCountInGroup = 8
var_0_0.ActivityId = 11610
var_0_0.SecondLayerFirstRoom = 1012001
var_0_0.EventStatus = {
	Finish = 2,
	NoStart = 0,
	Start = 1
}
var_0_0.BossType = {
	Elite = 2,
	Boss = 3,
	Normal = 1
}
var_0_0.EventPauseType = {
	Tips = 3,
	Choice = 2,
	GetCollecttions = 4,
	Request = 1,
	Normal = 0
}
var_0_0.TipStyle = {
	ChangeConclusion = 2,
	Normal = 1
}
var_0_0.DropType = {
	HeroPosUpgrade = 6,
	Collection = 5,
	ReviveEvent = 7,
	SelectCollection = 4,
	CureEvent = 2,
	CharacterGet = 3,
	Currency = 1
}
var_0_0.DropCurrencyType = {
	Coin = 1,
	Currency = 2
}
var_0_0.CureEventType = {
	All = 3,
	Single = 1,
	Random = 2
}
var_0_0.CollectionCategoryType = {
	All = 1,
	UnGet = 3,
	HasGet = 2
}
var_0_0.CollectionState = {
	UnLocked = 2,
	Locked = 3,
	HasGet = 1
}
var_0_0.CollectionType = {
	Weapon = 1,
	Magic = 4,
	Protect = 2,
	Enchant = 5,
	Decorate = 3
}
var_0_0.CollectionShowRare = {
	Enchant = 2,
	Boss = 3,
	Normal = 1
}
var_0_0.EmptyEnchantId = 0
var_0_0.CollectionInHandBook = 1
var_0_0.SpecialCollection = 91320070
var_0_0.HelpUnlockGuideId = 16503
var_0_0.Const = {
	LayerBGM = 14,
	MoveSpeed = 1,
	StoryNode2 = 10,
	StoryNode4 = 12,
	MainViewCollectionList = 3,
	RecoverEvent = 7,
	StoryNode3 = 11,
	HeartConst = 6,
	DoubleScoreLimit = 2,
	ChangeConclusion = 8,
	LayerFightScene = 15,
	FirstRoomValue = 19,
	StoryNode1 = 9,
	GiveupUpgrade = 5
}
var_0_0.CollectionTypeName = {
	[var_0_0.CollectionType.Weapon] = "cachot_CollectionTypeName_Weapon",
	[var_0_0.CollectionType.Protect] = "cachot_CollectionTypeName_Protect",
	[var_0_0.CollectionType.Decorate] = "cachot_CollectionTypeName_Decorate",
	[var_0_0.CollectionType.Magic] = "cachot_CollectionTypeName_Magic",
	[var_0_0.CollectionType.Enchant] = "cachot_CollectionTypeName_Enchant"
}
var_0_0.MainViewLevelID = 90001
var_0_0.ChoiceConditionType = {
	CoinCount = 3,
	CollectionCountGreater = 4,
	CollectionCountLess = 5,
	AllHeroLifeLess = 11,
	AllHeroLifeGreater = 10,
	CollectionGroupCountLess = 7,
	HeartRange = 2,
	HeartLess = 13,
	HeartGreater = 12,
	OneHeroLifeGreater = 8,
	CollectionGroupCountGreater = 6,
	OneHeroLifeLess = 9,
	HaveCollection = 1
}
var_0_0.HeroGroupEditType = {
	Fight = 2,
	Event = 3,
	Init = 1
}
var_0_0.GuideDragTipType = {
	Hide = 0,
	Right = 2,
	Left = 1
}
var_0_0.MilestonesState = {
	UnFinish = 0,
	Locked = 3,
	CanReceive = 1,
	HasReceived = 2
}
var_0_0.UnLockedRewardItemWidth = 240
var_0_0.LockedRewardItemWidth = 1033
var_0_0.CollectionHole = {
	Left = 1,
	Right = 2
}
var_0_0.DifficultyView = {
	HardMask = 3,
	NormalMask = 1,
	MiddleMask = 2
}
var_0_0.PlayerEffect = {
	RoleTransEffect = "RoleTransEffect",
	RoleBornEffect = "RoleBornEffect"
}
var_0_0.CoinId = 1603
var_0_0.CurrencyId = 1604

return var_0_0
