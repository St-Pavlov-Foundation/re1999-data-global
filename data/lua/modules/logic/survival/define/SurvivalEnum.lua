module("modules.logic.survival.define.SurvivalEnum", package.seeall)

local var_0_0 = _M

var_0_0.RainType = {
	Rain3 = 2,
	Rain2 = 3,
	Rain1 = 1
}
var_0_0.UnitType = {
	NPC = 5,
	Task = 7,
	Door = 8,
	Exit = 2,
	Search = 3,
	Born = 1,
	Treasure = 6,
	Battle = 4,
	Block = 9
}
var_0_0.UnitSubType = {
	Water = 96,
	Shop = 77,
	Ice = 95,
	Magma = 94,
	Miasma = 92,
	Morass = 93,
	BlockEvent = 791,
	Block = 91
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
	TornadoSpEvent = 4202,
	Vehicle_WaterNormal = 3906,
	HeroHealth2 = 2302,
	StoryFirstEnter = 4601,
	SurvivalHpFixRate_WorldLv = 3301,
	DoorCfgId = 10,
	HeroWeight = 12,
	TeamHealthState = 2318,
	RadarLv3 = 4101,
	PlayerRes = 6,
	FightExRule = 3201,
	ShelterMonsterSelectNpcMax = 2801,
	Vehicle_Magma = 3903,
	StoryHiddenEnding = 4603,
	Vehicle_Ice = 3904,
	Vehicle_Miasma = 3901,
	IceSpEvent = 4201,
	ShowEffectUnitSubTypes = 22,
	CarryNpcMax = 21,
	HeroHealth3 = 2303,
	HeroHealthMax = 2301,
	CarryHeroMax = 18,
	ExitCfgId = 9,
	TotalTime = 1,
	RadarLv1 = 4103,
	TreasureCfgId = 19,
	SurvivalHpFixRate_Hard = 3401,
	Vehicle_Morass = 3902,
	StoryPassEnter = 4602,
	RadarLv2 = 4102,
	NoShowIconUnitSubType = 4401,
	NoDisasterDesc = 4501,
	Vehicle_Water = 3905,
	ShelterCompositeCost = 2601
}
var_0_0.HardUnlockCondition = {
	overDifMult = "passMods",
	overDif = "overDif"
}
var_0_0.OperType = {
	PlayerMove = 1,
	SelectOption = 5,
	TriggerEvent = 2,
	OperSearch = 3,
	FightBack = 6
}
var_0_0.StepRunOrder = {
	Before = 1,
	After = 3,
	None = 2
}
var_0_0.StepType = {
	MapTickAfter = 22,
	TeleportGateUpdate = 32,
	FollowTaskUpdate = 16,
	UpdateUnitData = 6,
	ShowEventPanel = 4,
	CircleUpdate = 3,
	RemoveEventPanel = 10,
	FastBattle = 23,
	TweenCamera = 24,
	RemoExPoints = 27,
	RadarPositionUpdate = 31,
	CircleShrinkFinish = 14,
	RemovePoints = 30,
	UpdateSafeZoneInfo = 15,
	AddTalent = 35,
	UnitHide = 20,
	GameTimeUpdate = 2,
	SearchPanelChange = 33,
	UpdatePoints = 7,
	UnitMove = 1,
	AddExBlock = 26,
	DelTalent = 36,
	MagmaStatusUpdate = 29,
	UnitShow = 19,
	UpdateExPoints = 28,
	PlayExplodeEffect = 34,
	UpdateEventPanel = 5,
	PlayDialog = 17,
	StopMove = 37,
	PlayFastBattleEffect = 38,
	BeginFight = 12,
	ShowToast = 39
}
var_0_0.MagmaStatus = {
	Intermittent = 2,
	Active = 0,
	Normal = 1
}
var_0_0.PanelType = {
	TreeEvent = 2,
	Store = 4,
	DropSelect = 3,
	Search = 1,
	Decrees = 5,
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
	Pileup = 8,
	NPC = 6,
	DecreeSelect = 10,
	Reputation = 9,
	Material = 1,
	Currency = 2
}
var_0_0.CurrencyType = {
	Gold = 1,
	Enthusiastic = 4,
	Decoding = 5,
	Food = 3,
	Build = 2
}
var_0_0.ItemSubType = {
	Quick_TransferToEvent = 65,
	Quick_Revival = 64,
	Quick_SwapPos = 61,
	Quick_Summon = 63,
	Quick_Fly = 51,
	Quick_TransferUnitOut = 67,
	Quick_MakeItem = 68,
	Quick_CreateEvent = 56,
	Quick_Transfer = 58,
	Material_NPCItem = 101,
	Quick_CreateEvent2 = 57,
	Material_VehicleItem = 102,
	Quick_Exit = 52,
	Quick_AddTime = 59,
	Quick_TeleportGate = 66,
	Quick_ShowEvent = 55,
	Quick_DelObstructNPCFight = 62,
	Quick_DelEvent = 53,
	Quick_GetTalent = 54,
	Quick_ClearFog = 60
}
var_0_0.CustomUseItemSubType = {
	[var_0_0.ItemSubType.Quick_Fly] = true,
	[var_0_0.ItemSubType.Quick_ClearFog] = true,
	[var_0_0.ItemSubType.Quick_SwapPos] = true,
	[var_0_0.ItemSubType.Quick_DelObstructNPCFight] = true,
	[var_0_0.ItemSubType.Quick_TransferToEvent] = true,
	[var_0_0.ItemSubType.Quick_TransferUnitOut] = true
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
	[var_0_0.EventChoiceIcon.None] = SurvivalConst.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Task] = SurvivalConst.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.NPC] = SurvivalConst.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.Search] = SurvivalConst.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.Treasure] = SurvivalConst.EventChoiceColor.Green,
	[var_0_0.EventChoiceIcon.Fight] = SurvivalConst.EventChoiceColor.Red,
	[var_0_0.EventChoiceIcon.FightElite] = SurvivalConst.EventChoiceColor.Red,
	[var_0_0.EventChoiceIcon.Exit] = SurvivalConst.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Obstruct] = SurvivalConst.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Talk] = SurvivalConst.EventChoiceColor.Yellow,
	[var_0_0.EventChoiceIcon.Return] = SurvivalConst.EventChoiceColor.Yellow
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
	StoryTask = 3,
	MainTask = 1,
	MapMainTarget = 5,
	SubTask = 2,
	NormalTask = 4
}
var_0_0.AttrType = {
	ChoiceCostTime = 811,
	BuildCost = 102,
	HealthInc = 601,
	RepairCost = 103,
	NpcFoodCost = 101,
	BalanceResonanceLv = 702,
	SurvivalFightFail = 502,
	AttrWeight = 813,
	Day = 802,
	BuyPriceFix = 301,
	DecreeNum = 402,
	ExploreNpcNum = 807,
	Vision2 = 818,
	BalanceRoleLv = 701,
	Vehicle_Magma = 1003,
	Vision = 801,
	PolluteSpeed = 804,
	SurvivalTimeFail = 504,
	CoinChangeRate = 814,
	HealthDec = 501,
	Vehicle_Ice = 1004,
	FoodChangeRate = 816,
	Vehicle_Miasma = 1001,
	MapSellPriceFix = 824,
	HeroFightLevel = 812,
	MoveCost = 803,
	CantTreatToRelive = 104,
	ExploreRoleNum = 806,
	BuildChangeRate = 815,
	Vehicle_Water = 1005,
	BuildSellPriceFix = 304,
	DecodingFix = 1202,
	DropNum = 201,
	ItemCopyRateFix = 822,
	ExtraCoin = 820,
	WarningRange = 1201,
	HeroHealthMax = 105,
	ShelterFightFail = 503,
	BuildNpcCapNum = 401,
	DropSelectNum = 202,
	HeroHealthRest = 404,
	BalanceEquipLv = 703,
	SurvivalInRange = 505,
	RenownChangeFix = 825,
	Vehicle_Morass = 1002,
	NpcRecruitment = 810,
	ShopBuyPriceFix = 823,
	LoungeRoleNum = 403,
	NoWarning = 817,
	ItemCopyRate = 821,
	EvacuateLoss = 805,
	WorldLevel = 808,
	BuildBuyPriceFix = 303,
	SellPriceFix = 302
}
var_0_0.AttrTypePer = {
	[var_0_0.AttrType.BuyPriceFix] = true,
	[var_0_0.AttrType.SellPriceFix] = true,
	[var_0_0.AttrType.BuildBuyPriceFix] = true,
	[var_0_0.AttrType.BuildSellPriceFix] = true,
	[var_0_0.AttrType.HealthDec] = true,
	[var_0_0.AttrType.HealthInc] = true,
	[var_0_0.AttrType.NpcRecruitment] = true,
	[var_0_0.AttrType.ChoiceCostTime] = true,
	[var_0_0.AttrType.BuildCost] = true,
	[var_0_0.AttrType.RepairCost] = true,
	[var_0_0.AttrType.NpcFoodCost] = true,
	[var_0_0.AttrType.ShopBuyPriceFix] = true,
	[var_0_0.AttrType.MapSellPriceFix] = true,
	[var_0_0.AttrType.RenownChangeFix] = true,
	[var_0_0.AttrType.DecodingFix] = true
}
var_0_0.PlayerMoveReason = {
	Fly = 4,
	Transfer = 3,
	Tornado = 5,
	Swap = 6,
	Back = 2,
	Summon = 7,
	Normal = 1
}
var_0_0.UnitDeadReason = {
	DieByQuickItem = 2006,
	PlayDieAnim = 2003
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
var_0_0.BuildingType = {
	Base = 1,
	Task = 4,
	Population = 3,
	Npc = 9,
	Explore = 5,
	Warehouse = 10,
	Shop = 11,
	ReputationShop = 12,
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
var_0_0.HandBookType = {
	Amplifier = 2,
	Result = 4,
	Event = 3,
	Npc = 1
}
var_0_0.HandBookTypeToName = {}

for iter_0_6, iter_0_7 in pairs(var_0_0.HandBookType) do
	var_0_0.HandBookTypeToName[iter_0_7] = iter_0_6
end

var_0_0.HandBookEventSubType = {
	Fight = 2,
	Task = 3,
	Search = 1
}
var_0_0.HandBookAmplifierSubType = {
	Common = 1,
	Bloom = 4,
	ElectricEnergy = 2,
	ExtraActions = 5,
	Ceremony = 6,
	Revelation = 3,
	StateAbnormal = 7
}
var_0_0.HandBookAmplifierSubTypeUIPos = {
	var_0_0.HandBookAmplifierSubType.Common,
	var_0_0.HandBookAmplifierSubType.Bloom,
	var_0_0.HandBookAmplifierSubType.ElectricEnergy,
	var_0_0.HandBookAmplifierSubType.Revelation,
	var_0_0.HandBookAmplifierSubType.Ceremony,
	var_0_0.HandBookAmplifierSubType.ExtraActions,
	var_0_0.HandBookAmplifierSubType.StateAbnormal
}
var_0_0.HandBookNpcSubType = {
	Foundation = 3,
	People = 1,
	Laplace = 2,
	Zeno = 4
}
var_0_0.ReputationType = {
	Zeno = 2,
	People = 1,
	Laplace = 4,
	Foundation = 3
}
var_0_0.ShopType = {
	Reputation = 2,
	PreExplore = 3,
	GeneralShop = 4,
	Normal = 1
}

return var_0_0
