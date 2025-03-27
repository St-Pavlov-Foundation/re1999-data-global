module("modules.logic.rouge.define.RougeEnum", package.seeall)

slot0 = _M
slot0.ResPath = {
	rougepageprogress = "ui/viewres/rouge/rougepageprogress.prefab",
	CollectionLevelUpLeftItem = "ui/viewres/rouge/dlc/102/rougecollectionlevelupleftitem.prefab",
	CollectionLevelUpRightItem = "ui/viewres/rouge/dlc/102/rougecollectionleveluprightitem.prefab",
	CommonLvItem = "ui/viewres/rouge/rougeitemlv.prefab",
	rougedifficultyitem = "ui/viewres/rouge/rougedifficultyitem.prefab",
	CollectionIconItem = "ui/viewres/rouge/rougecollectioniconitem.prefab",
	rougefactionitem = "ui/viewres/rouge/rougefactionitem.prefab",
	CommonCollectionItem = "ui/viewres/rouge/rougeitemcollection.prefab",
	CommonHeroGroupItem = "ui/viewres/rouge/rougeitemherogroup.prefab",
	CoinView = "ui/viewres/rouge/map/rougemapcoinview.prefab",
	CollectionDetailBtnItem = "ui/viewres/rouge/map/rougemapdetailview.prefab",
	CommonCollectionSlotItem = "ui/viewres/rouge/rougecollectionslotitem.prefab"
}
slot0.TalentState = {
	CannotActivated = 4,
	CanActivated = 3,
	Activated = 1,
	Disabled = 5,
	SiblingActivated = 2
}
slot0.HelpState = {
	Full = 3,
	UnSelected = 2,
	Selected = 1
}
slot0.TeamType = {
	Treat = 2,
	View = 1,
	Assignment = 4,
	Revive = 3
}
slot0.FavoriteType = {
	Illustration = 3,
	Collection = 1,
	Story = 4,
	Faction = 2
}
slot0.FirstLayerId = 111
slot0.CollectionListViewDelayTime = 0.3
slot0.IllustrationNumOfPage = 6
slot0.InitTeamHeroNum = 8
slot0.FightTeamHeroNum = 8
slot0.FightTeamNormalHeroNum = 4
slot0.DefaultTeamHeroNum = 4
slot0.HeroGroupEditType = {
	Fight = 2,
	FightAssit = 3,
	SelectHero = 4,
	Init = 1
}
slot0.Const = {
	RewardTranslation = 1018,
	RoleHalfCapacity = 9,
	EndingThreeContent = 6002,
	TalentTranslation = 1019,
	AchievementJumpId = 51,
	RoleCapacity = 2,
	FavoriteEndingShow = 42,
	EndingThreeTitle = 6001,
	TalentCost = 27,
	SelectHeroCapacity = 8,
	CompositeEntryVisible = 47,
	TalentBigNode = 25
}
slot0.OutsideConst = {
	RewardCost = 2,
	SkillPointLimit = 1,
	RewardPointLimit = 4,
	StartNode = 101
}
slot0.BigRewardType = {
	Multi = 4,
	RoomItem = 2,
	Role = 1,
	Skin = 5,
	Artifice = 3
}
slot0.CollectionHeight = {
	Big = 285,
	Small = 224
}
slot0.CollectionListRowNum = 5
slot0.MaxCollectionSlotSize = Vector2(8, 8)
slot0.MaxCollectionBagSize = Vector2(8, 7)
slot0.MinCollectionExtraTagID = 100
slot0.CompositeCollectionCostCount = 1
slot0.MaxLevelSpAttrId = 4001
slot0.CollectionEditorParamType = {
	CenterPos = 4,
	Effect = "effectArea",
	DragPos = "dragPos",
	ShapeSize = "shapeSize",
	Shape = "shapeArea",
	IconOffset = "iconOffset",
	LeftTopPos = "leftTopPos",
	shapeMatrix = "shapeMatrix"
}
slot0.LineState = {
	Blue = 4,
	Green = 3,
	Red = 2,
	Grey = 1
}
slot0.SlotCellDirection = {
	Top = 1,
	Left = 3,
	Bottom = 2,
	Right = 4
}
slot0.CollectionType = {
	Weapon = 103,
	Magic = 104,
	Protect = 102,
	Special = 107,
	Baggage = 106,
	Decorate = 101,
	Enchant = 105
}
slot0.CollectionTypeSort = {
	[slot0.CollectionType.Weapon] = 1,
	[slot0.CollectionType.Protect] = 2,
	[slot0.CollectionType.Decorate] = 3,
	[slot0.CollectionType.Magic] = 4,
	[slot0.CollectionType.Enchant] = 5,
	[slot0.CollectionType.Baggage] = 6,
	[slot0.CollectionType.Special] = 7
}
slot0.CollectionTipPos = {
	Slot = Vector2(310, 0),
	Bag = Vector2(-340, 0),
	CompositeBaseCollection = Vector2(-430, 0),
	OverView = Vector2(0, 0),
	HandBook = Vector2(-310, 0)
}
slot0.EmptyEnchantId = 0
slot0.CollectionRotation = {
	Rotation_270 = 3,
	Rotation_90 = 1,
	Rotation_0 = 0,
	Rotation_180 = 2
}
slot0.OpenCollectionTipSource = {
	BagArea = 2,
	SlotArea = 1,
	ChoiceView = 3
}
slot0.CollectionReason = {
	Composite = 2,
	Product = 1,
	Other = 0
}
slot0.CollectionPlaceArea = {
	SlotArea = 1,
	BagArea = 2
}
slot0.State = {
	Style = 3,
	isEnd = 5,
	LastReward = 2,
	Difficulty = 1,
	Start = 4,
	Empty = 0
}
slot0.CollectionBgMaxSize = 4
slot0.EffectActiveType = {
	Electric = 1,
	Engulf = 2,
	LevelUp = 3,
	Null = 0
}
slot0.EffectTriggerType = {
	LevelUp = 2,
	Engulf = 1,
	Null = 0
}
slot0.CollectionArtType = {
	LevelUpLine = 6,
	EngulfLine = 7,
	Place = 1,
	EngulfTrigger2 = 11,
	Effect = 2,
	LevelUPTrigger1 = 8,
	LevelUPTrigger2 = 9,
	EngulfTrigger1 = 10,
	LevelUP = 5,
	Lighting = 3,
	Engulf = 4,
	None = 0
}
slot0.CollectionInfoType = {
	Complex = 2,
	Simple = 1
}
slot0.DefaultCollectionInfoType = slot0.CollectionInfoType.Simple
slot0.CollectionEntryState = {
	Icon = 2,
	Grid = 1
}
slot0.PopType = {
	ViewName = 1,
	Func = 2
}
slot0.StartViewEnum = {
	point = "point",
	capacity = "capacity",
	coin = "coin",
	power = "power",
	powerLimit = "powerLimit"
}
slot0.SkillType = {
	Style = "skill",
	Map = "mapSkill"
}
slot0.SkillTypeSortEnum = {
	[slot0.SkillType.Style] = 1,
	[slot0.SkillType.Map] = 2
}
slot0.CollectionDescType = {
	Text = 3,
	SpecialHeader = 4,
	BaseEffect = 2,
	ExtraEffect = 1,
	SpecialText = 5
}
slot0.CollectionDescTypeSort = {
	[slot0.CollectionDescType.SpecialHeader] = 1,
	[slot0.CollectionDescType.ExtraEffect] = 2,
	[slot0.CollectionDescType.BaseEffect] = 3,
	[slot0.CollectionDescType.SpecialText] = 4,
	[slot0.CollectionDescType.Text] = 5
}
slot0.IllustrationType = {
	DLC = 2,
	Normal = 1
}
slot0.CollectionDescSource = {
	Config = 1,
	Inst = 2
}
slot0.EndingThreeId = 103

return slot0
