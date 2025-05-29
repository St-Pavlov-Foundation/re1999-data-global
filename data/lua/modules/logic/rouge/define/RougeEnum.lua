module("modules.logic.rouge.define.RougeEnum", package.seeall)

local var_0_0 = _M

var_0_0.ResPath = {
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
var_0_0.TalentState = {
	CannotActivated = 4,
	CanActivated = 3,
	Activated = 1,
	Disabled = 5,
	SiblingActivated = 2
}
var_0_0.HelpState = {
	Full = 3,
	UnSelected = 2,
	Selected = 1
}
var_0_0.TeamType = {
	Treat = 2,
	View = 1,
	Assignment = 4,
	Revive = 3
}
var_0_0.FavoriteType = {
	Illustration = 3,
	Collection = 1,
	Story = 4,
	Faction = 2
}
var_0_0.FirstLayerId = 111
var_0_0.CollectionListViewDelayTime = 0.3
var_0_0.IllustrationNumOfPage = 6
var_0_0.InitTeamHeroNum = 8
var_0_0.FightTeamHeroNum = 8
var_0_0.FightTeamNormalHeroNum = 4
var_0_0.DefaultTeamHeroNum = 4
var_0_0.HeroGroupEditType = {
	Fight = 2,
	FightAssit = 3,
	SelectHero = 4,
	Init = 1
}
var_0_0.Const = {
	RecoverExtraPoint = 8001,
	EndingThreeContent = 6002,
	FourthEndingStoryId = 9002,
	FourthEndingChoiceIds = 9001,
	AchievementJumpId = 51,
	RoleCapacity = 2,
	MaxExtraPoint = 8002,
	TalentCost = 27,
	SelectHeroCapacity = 8,
	RewardTranslation = 1018,
	TalentTranslation = 1019,
	RoleHalfCapacity = 9,
	FavoriteEndingShow = 42,
	EndingThreeTitle = 6001,
	CompositeEntryVisible = 47,
	AddExraPoint = 8003,
	TalentBigNode = 25
}
var_0_0.OutsideConst = {
	RewardCost = 2,
	SkillPointLimit = 1,
	RewardPointLimit = 4,
	StartNode = 101
}
var_0_0.BigRewardType = {
	Triple = 6,
	RoomItem = 2,
	Double = 4,
	Role = 1,
	Skin = 5,
	Artifice = 3
}
var_0_0.CollectionHeight = {
	Big = 285,
	Small = 224
}
var_0_0.CollectionListRowNum = 5
var_0_0.MaxCollectionSlotSize = Vector2(8, 8)
var_0_0.MaxCollectionBagSize = Vector2(8, 7)
var_0_0.MinCollectionExtraTagID = 100
var_0_0.CompositeCollectionCostCount = 1
var_0_0.MaxLevelSpAttrId = 4001
var_0_0.CollectionEditorParamType = {
	CenterPos = 4,
	Effect = "effectArea",
	DragPos = "dragPos",
	ShapeSize = "shapeSize",
	Shape = "shapeArea",
	IconOffset = "iconOffset",
	LeftTopPos = "leftTopPos",
	shapeMatrix = "shapeMatrix"
}
var_0_0.LineState = {
	Blue = 4,
	Green = 3,
	Red = 2,
	Grey = 1
}
var_0_0.SlotCellDirection = {
	Top = 1,
	Left = 3,
	Bottom = 2,
	Right = 4
}
var_0_0.CollectionType = {
	Weapon = 103,
	Magic = 104,
	Price = 108,
	Special = 107,
	Baggage = 106,
	Decorate = 101,
	Enchant = 105,
	Protect = 102
}
var_0_0.CollectionTypeSort = {
	[var_0_0.CollectionType.Weapon] = 1,
	[var_0_0.CollectionType.Protect] = 2,
	[var_0_0.CollectionType.Decorate] = 3,
	[var_0_0.CollectionType.Magic] = 4,
	[var_0_0.CollectionType.Enchant] = 5,
	[var_0_0.CollectionType.Baggage] = 6,
	[var_0_0.CollectionType.Special] = 7,
	[var_0_0.CollectionType.Price] = 8
}
var_0_0.CollectionTipPos = {
	Slot = Vector2(310, 0),
	Bag = Vector2(-340, 0),
	CompositeBaseCollection = Vector2(-430, 0),
	OverView = Vector2(0, 0),
	HandBook = Vector2(-310, 0),
	MapRule = Vector2(-340, 0)
}
var_0_0.EmptyEnchantId = 0
var_0_0.CollectionRotation = {
	Rotation_270 = 3,
	Rotation_90 = 1,
	Rotation_0 = 0,
	Rotation_180 = 2
}
var_0_0.OpenCollectionTipSource = {
	BagArea = 2,
	SlotArea = 1,
	ChoiceView = 3
}
var_0_0.CollectionReason = {
	Composite = 2,
	Product = 1,
	Other = 0
}
var_0_0.CollectionPlaceArea = {
	SlotArea = 1,
	BagArea = 2
}
var_0_0.State = {
	Style = 3,
	isEnd = 5,
	LastReward = 2,
	Difficulty = 1,
	Start = 4,
	Empty = 0
}
var_0_0.CollectionBgMaxSize = 4
var_0_0.EffectActiveType = {
	Electric = 1,
	Engulf = 2,
	LevelUp = 3,
	Null = 0
}
var_0_0.EffectTriggerType = {
	LevelUp = 2,
	Engulf = 1,
	Null = 0
}
var_0_0.CollectionArtType = {
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
var_0_0.CollectionInfoType = {
	Complex = 2,
	Simple = 1
}
var_0_0.DefaultCollectionInfoType = var_0_0.CollectionInfoType.Simple
var_0_0.CollectionEntryState = {
	Icon = 2,
	Grid = 1
}
var_0_0.PopType = {
	ViewName = 1,
	Func = 2
}
var_0_0.StartViewEnum = {
	point = "point",
	capacity = "capacity",
	coin = "coin",
	power = "power",
	powerLimit = "powerLimit"
}
var_0_0.SkillType = {
	Style = "skill",
	Map = "mapSkill"
}
var_0_0.SkillTypeSortEnum = {
	[var_0_0.SkillType.Style] = 1,
	[var_0_0.SkillType.Map] = 2
}
var_0_0.CollectionDescType = {
	Text = 3,
	SpecialHeader = 4,
	BaseEffect = 2,
	ExtraEffect = 1,
	SpecialText = 5
}
var_0_0.CollectionDescTypeSort = {
	[var_0_0.CollectionDescType.SpecialHeader] = 1,
	[var_0_0.CollectionDescType.ExtraEffect] = 2,
	[var_0_0.CollectionDescType.BaseEffect] = 3,
	[var_0_0.CollectionDescType.SpecialText] = 4,
	[var_0_0.CollectionDescType.Text] = 5
}
var_0_0.IllustrationType = {
	DLC = 2,
	Normal = 1
}
var_0_0.CollectionDescSource = {
	Config = 1,
	Inst = 2
}
var_0_0.EndingThreeId = 103

return var_0_0
