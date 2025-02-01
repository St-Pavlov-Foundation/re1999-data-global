module("modules.logic.versionactivity1_6.v1a6_cachot.define.V1a6_CachotEnum", package.seeall)

slot0 = _M
slot0.EventType = {
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
slot0.NoLimit = "3"
slot0.HeroCountInGroup = 4
slot0.MaxHeroCountInGroup = 4
slot0.InitTeamMaxHeroCountInGroup = 8
slot0.ActivityId = 11610
slot0.SecondLayerFirstRoom = 1012001
slot0.EventStatus = {
	Finish = 2,
	NoStart = 0,
	Start = 1
}
slot0.BossType = {
	Elite = 2,
	Boss = 3,
	Normal = 1
}
slot0.EventPauseType = {
	Tips = 3,
	Choice = 2,
	GetCollecttions = 4,
	Request = 1,
	Normal = 0
}
slot0.TipStyle = {
	ChangeConclusion = 2,
	Normal = 1
}
slot0.DropType = {
	HeroPosUpgrade = 6,
	Collection = 5,
	ReviveEvent = 7,
	SelectCollection = 4,
	CureEvent = 2,
	CharacterGet = 3,
	Currency = 1
}
slot0.DropCurrencyType = {
	Coin = 1,
	Currency = 2
}
slot0.CureEventType = {
	All = 3,
	Single = 1,
	Random = 2
}
slot0.CollectionCategoryType = {
	All = 1,
	UnGet = 3,
	HasGet = 2
}
slot0.CollectionState = {
	UnLocked = 2,
	Locked = 3,
	HasGet = 1
}
slot0.CollectionType = {
	Weapon = 1,
	Magic = 4,
	Protect = 2,
	Enchant = 5,
	Decorate = 3
}
slot0.CollectionShowRare = {
	Enchant = 2,
	Boss = 3,
	Normal = 1
}
slot0.EmptyEnchantId = 0
slot0.CollectionInHandBook = 1
slot0.SpecialCollection = 91320070
slot0.HelpUnlockGuideId = 16503
slot0.Const = {
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
slot0.CollectionTypeName = {
	[slot0.CollectionType.Weapon] = "cachot_CollectionTypeName_Weapon",
	[slot0.CollectionType.Protect] = "cachot_CollectionTypeName_Protect",
	[slot0.CollectionType.Decorate] = "cachot_CollectionTypeName_Decorate",
	[slot0.CollectionType.Magic] = "cachot_CollectionTypeName_Magic",
	[slot0.CollectionType.Enchant] = "cachot_CollectionTypeName_Enchant"
}
slot0.MainViewLevelID = 90001
slot0.ChoiceConditionType = {
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
slot0.HeroGroupEditType = {
	Fight = 2,
	Event = 3,
	Init = 1
}
slot0.GuideDragTipType = {
	Hide = 0,
	Right = 2,
	Left = 1
}
slot0.MilestonesState = {
	UnFinish = 0,
	Locked = 3,
	CanReceive = 1,
	HasReceived = 2
}
slot0.UnLockedRewardItemWidth = 240
slot0.LockedRewardItemWidth = 1033
slot0.CollectionHole = {
	Left = 1,
	Right = 2
}
slot0.DifficultyView = {
	HardMask = 3,
	NormalMask = 1,
	MiddleMask = 2
}
slot0.PlayerEffect = {
	RoleTransEffect = "RoleTransEffect",
	RoleBornEffect = "RoleBornEffect"
}
slot0.CoinId = 1603
slot0.CurrencyId = 1604

return slot0
