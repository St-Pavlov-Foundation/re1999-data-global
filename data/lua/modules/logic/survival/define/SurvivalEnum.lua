module("modules.logic.survival.define.SurvivalEnum", package.seeall)

local var_0_0 = _M

var_0_0.UnitType = {
	Search = 3,
	Task = 7,
	Treasure = 6,
	Exit = 2,
	NPC = 5,
	Born = 1,
	Battle = 4,
	Door = 8
}
var_0_0.Dir = {
	BottomRight = 1,
	TopLeft = 4,
	Right = 0,
	TopRight = 5,
	BottomLeft = 2,
	Left = 3
}
var_0_0.DirToPos = {
	[var_0_0.Dir.Right] = SurvivalHexNode.New(1, 0, -1),
	[var_0_0.Dir.BottomRight] = SurvivalHexNode.New(0, 1, -1),
	[var_0_0.Dir.BottomLeft] = SurvivalHexNode.New(-1, 1, 0),
	[var_0_0.Dir.Left] = SurvivalHexNode.New(-1, 0, 1),
	[var_0_0.Dir.TopLeft] = SurvivalHexNode.New(0, -1, 1),
	[var_0_0.Dir.TopRight] = SurvivalHexNode.New(1, -1, 0)
}
var_0_0.ConstId = {
	ShelterMonsterSelectNpcMax = 2801,
	TeamHealthState = 2318,
	TalentDesc = 23,
	HeroWeight = 12,
	CarryNpcMax = 21,
	HeroHealth3 = 2303,
	HeroHealthMax = 2301,
	DoorCfgId = 10,
	FightExRule = 3201,
	PlayerRes = 6,
	CarryHeroMax = 18,
	ExitCfgId = 9,
	TotalTime = 1,
	SurvivalHpFixRate_WorldLv = 3301,
	TreasureCfgId = 19,
	HeroHealth2 = 2302,
	SurvivalHpFixRate_Hard = 3401,
	ShowEffectUnitSubTypes = 22,
	ShelterCompositeCost = 2601
}
var_0_0.OperType = {
	PlayerMove = 1,
	SelectOption = 5,
	TriggerEvent = 2,
	OperSearch = 3,
	FightBack = 6
}
var_0_0.StepType = {
	ShowEventPanel = 4,
	UpdateUnitData = 6,
	FollowTaskUpdate = 16,
	UpdateSafeZoneInfo = 15,
	MapTickAfter = 22,
	CircleUpdate = 3,
	RemoveEventPanel = 10,
	FastBattle = 23,
	TweenCamera = 24,
	UpdateTalentCount = 25,
	CircleShrinkFinish = 14,
	UnitHide = 20,
	GameTimeUpdate = 2,
	UpdatePoints = 7,
	UnitMove = 1,
	GetTalent = 18,
	UnitShow = 19,
	UpdateEventPanel = 5,
	PlayDialog = 17,
	BeginFight = 12
}
var_0_0.PanelType = {
	TreeEvent = 2,
	Store = 4,
	DropSelect = 3,
	Search = 1,
	None = 0
}
var_0_0.FightStatu = {
	Win = 1,
	Lose = 2,
	None = 0
}
var_0_0.ItemType = {
	Quick = 5,
	Equip = 7,
	NPC = 6,
	Material = 1,
	Currency = 2
}
var_0_0.CurrencyType = {
	Gold = 1,
	Enthusiastic = 4,
	Food = 3,
	Likability = 5,
	Build = 2
}
var_0_0.ItemSubType = {
	Quick_GetTalent = 54,
	Quick_ClearFog = 60,
	Quick_Fly = 51,
	Quick_ShowEvent = 55,
	Quick_CreateEvent = 56,
	Quick_Transfer = 58,
	Quick_DelEvent = 53,
	Quick_CreateEvent2 = 57,
	Quick_Exit = 52,
	Quick_AddTime = 59
}
var_0_0.CustomUseItemSubType = {
	[var_0_0.ItemSubType.Quick_Fly] = true,
	[var_0_0.ItemSubType.Quick_ClearFog] = true
}
var_0_0.ItemSource = {
	Commited = -5,
	Equip = -2,
	Map = 1,
	Drop = -10,
	ShopItem = -7,
	Commit = -4,
	Info = -9,
	Composite = -8,
	Search = -1,
	ShopBag = -6,
	EquipBag = -3,
	Shelter = 2,
	None = 0
}
var_0_0.HelpState = {
	Full = 3,
	UnSelected = 2,
	Selected = 1
}
var_0_0.GameTimeUpdateReason = {
	Cost = 2,
	Normal = 1
}
var_0_0.MapResult = {
	Win = 1,
	Lose = 2,
	None = 0
}
var_0_0.MapSettleReason = {
	HealthLimit = 1,
	Abort = 3,
	TimeLimit = 2,
	UseItem = 4,
	Success = 0
}
var_0_0.Shelter_EpisodeId = 1280601
var_0_0.Survival_EpisodeId = 1280602
var_0_0.StepTypeToName = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.StepType) do
	var_0_0.StepTypeToName[iter_0_1] = iter_0_0
end

var_0_0.UnitTypeToName = {}

for iter_0_2, iter_0_3 in pairs(var_0_0.UnitType) do
	var_0_0.UnitTypeToName[iter_0_3] = iter_0_2
end

var_0_0.BuildingStatus = {
	Destroy = 1,
	Normal = 0
}
var_0_0.HeroStatu = {
	HasBuff = 1,
	Hurt = 2,
	Normal = 0
}
var_0_0.NpcStatus = {
	HomeBreak = 2,
	OutSide = 1,
	HomeLess = 3,
	Normal = 0
}
var_0_0.EventChoiceColor = {
	Yellow = "#B28135",
	Green = "#7FAA88",
	Gray = "#F5F1EB",
	Red = "#FF7C72"
}
var_0_0.EventChoiceIcon = {
	NPC = 2,
	Task = 1,
	Talk = 14,
	Search = 3,
	Return = 15,
	Treasure = 5,
	Fight = 6,
	FightElite = 7,
	Exit = 8,
	Obstruct = 9,
	None = 0
}
var_0_0.IconToColor = {
	[var_0_0.EventChoiceIcon.None] = var_0_0.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Task] = var_0_0.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.NPC] = var_0_0.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.Search] = var_0_0.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.Treasure] = var_0_0.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.Fight] = var_0_0.EventChoiceColor.Red,
	[var_0_0.EventChoiceIcon.FightElite] = var_0_0.EventChoiceColor.Red,
	[var_0_0.EventChoiceIcon.Exit] = var_0_0.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Obstruct] = var_0_0.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Talk] = var_0_0.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Return] = var_0_0.EventChoiceColor.Yellow
}
var_0_0.ItemSortType = {
	ItemReward = 8,
	EquipTag = 5,
	Time = 4,
	Type = 3,
	Worth = 2,
	Result = 7,
	NPC = 6,
	Mass = 1
}
var_0_0.ItemFilterType = {
	Equip = 2,
	Material = 1,
	Consume = 3
}
var_0_0.TaskStatus = {
	Done = 2,
	Doing = 1,
	Fail = 4,
	Finish = 3
}
var_0_0.TaskModule = {
	DecreeTask = 5,
	MainTask = 1,
	StoryTask = 3,
	SubTask = 2,
	NormalTask = 4
}
var_0_0.AttrType = {
	ChoiceCostTime = 811,
	BuildCost = 102,
	NpcFoodCost = 101,
	HeroWeight = 809,
	CantTreatToRelive = 104,
	BalanceResonanceLv = 702,
	SurvivalFightFail = 502,
	AttrWeight = 813,
	Day = 802,
	RepairCost = 103,
	DecreeNum = 402,
	ExploreNpcNum = 807,
	MoveCost = 803,
	BalanceRoleLv = 701,
	HeroHealthMax = 105,
	Vision = 801,
	PolluteSpeed = 804,
	SurvivalTimeFail = 504,
	CoinChangeRate = 814,
	HealthDec = 501,
	BuildChangeRate = 815,
	FoodChangeRate = 816,
	NoWarming = 817,
	HeroFightLevel = 812,
	ExploreRoleNum = 806,
	HealthInc = 601,
	DropNum = 201,
	BuyPriceFix = 301,
	ShelterFightFail = 503,
	BuildNpcCapNum = 401,
	DropSelectNum = 202,
	HeroHealthRest = 404,
	BalanceEquipLv = 703,
	SurvivalInRange = 505,
	NpcRecruitment = 810,
	LoungeRoleNum = 403,
	EvacuateLoss = 805,
	WorldLevel = 808,
	SellPriceFix = 302
}
var_0_0.AttrTypePer = {
	[var_0_0.AttrType.BuyPriceFix] = true,
	[var_0_0.AttrType.SellPriceFix] = true,
	[var_0_0.AttrType.HealthDec] = true,
	[var_0_0.AttrType.HealthInc] = true,
	[var_0_0.AttrType.NpcRecruitment] = true,
	[var_0_0.AttrType.ChoiceCostTime] = true,
	[var_0_0.AttrType.BuildCost] = true,
	[var_0_0.AttrType.RepairCost] = true,
	[var_0_0.AttrType.NpcFoodCost] = true
}
var_0_0.UnitEffectPath = {
	Fly = "survival/effects/prefab/v2a8_scene_yidong.prefab",
	FastFight = "survival/effects/prefab/v2a8_scene_tiaoguo.prefab",
	CreateUnit = "survival/effects/prefab/v2a8_scene_bianshen.prefab",
	UnitType42 = "survival/effects/prefab/v2a8_scene_smoke_01.prefab",
	UnitType44 = "survival/effects/prefab/v2a8_scene_smoke_02.prefab",
	Transfer2 = "survival/effects/prefab/v2a8_scene_chuansong_01.prefab",
	FollowUnit = "survival/effects/prefab/v2a8_scene_jinguang.prefab",
	Transfer1 = "survival/effects/prefab/v2a8_scene_chuansong_02.prefab"
}
var_0_0.UnitEffectTime = {
	[var_0_0.UnitEffectPath.FastFight] = 1,
	[var_0_0.UnitEffectPath.Fly] = 0.4,
	[var_0_0.UnitEffectPath.Transfer1] = 0.8,
	[var_0_0.UnitEffectPath.Transfer2] = 0.8,
	[var_0_0.UnitEffectPath.CreateUnit] = 2
}
var_0_0.PlayerMoveReason = {
	Transfer = 3,
	Back = 2,
	Fly = 4,
	Normal = 1
}
var_0_0.NpcRecruitmentType = {
	NpcNumCheck = 3,
	WorthCheck = 4,
	FinishTask = 5,
	FinishEvent = 6,
	ItemCost = 1,
	ItemCheck = 2
}
var_0_0.ConditionOper = {
	GE = 1,
	LE = 3,
	EQ = 2
}
var_0_0.EntityChildKey = {
	ModelGOKey = "model",
	BodyGOKey = "body",
	HeadGOKey = "head"
}
var_0_0.CustomDifficulty = 9999
var_0_0.FirstPlayDifficulty = 999
var_0_0.ItemRareColor = {
	"#27682e",
	"#6384E5",
	"#C28DC7",
	"#D2C197",
	"#E99B56"
}
var_0_0.ItemRareColor2 = {
	"#27682e",
	"#324bb6",
	"#804885",
	"#897519",
	"#ac5320"
}
var_0_0.BuildingType = {
	Base = 1,
	Task = 4,
	Population = 3,
	Npc = 9,
	Explore = 5,
	Warehouse = 10,
	Shop = 11,
	Equipment = 8,
	Decree = 2,
	Health = 6,
	Tent = 7
}
var_0_0.InfoShowType = {
	Npc = 2,
	Building = 1,
	NpcOnlyConfig = 3,
	None = 0
}
var_0_0.ShelterNpcStatus = {
	NotInBuild = 0,
	InDestoryBuild = 2,
	InBuild = 1,
	OutSide = 3
}
var_0_0.ShelterUnitType = {
	Monster = 3,
	VoteEntity = 5,
	Player = 4,
	Npc = 1,
	Build = 2
}
var_0_0.ShelterMonsterFightState = {
	Fighting = 2,
	Abandon = 4,
	Fail = 3,
	NoStart = 1,
	Win = 5
}
var_0_0.ShelterTagColor = {
	"#986452",
	"#74657F",
	"#6A837F",
	"#5E6D94"
}
var_0_0.ShelterUnitTypeToName = {}

for iter_0_4, iter_0_5 in pairs(var_0_0.ShelterUnitType) do
	var_0_0.ShelterUnitTypeToName[iter_0_5] = iter_0_4
end

var_0_0.ShelterBuildingBtnStatus = {
	Destroy = 1,
	New = 3,
	Levelup = 2,
	Normal = 0
}
var_0_0.ShelterDecreeStatus = {
	UnFinish = 1,
	Finish = 2,
	Normal = 0
}
var_0_0.ShelterBtnUnlockType = {
	BuildingTypeLev = 1
}
var_0_0.ShelterGridType = {
	Triangle = 2,
	Single = 1
}
var_0_0.NpcSubType = {
	Story = 52,
	Normal = 51
}
var_0_0.SurvivalIntrudeAbandonBlock = "SurvivalIntrudeAbandonBlock"
var_0_0.ShelterBuildingLocalStatus = {
	Destroy = 1,
	NormalToDestroy = 102,
	DestroyToNormal = 101,
	UnBuildToNormal = 103,
	BaseStatus = 100,
	UnBuild = 2,
	Normal = 0
}
var_0_0.SurvivalMonsterEventViewShowType = {
	Watch = 1,
	Normal = 0
}
var_0_0.MoveSpeed = 0.4

return var_0_0
