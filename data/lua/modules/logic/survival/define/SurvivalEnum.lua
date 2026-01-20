-- chunkname: @modules/logic/survival/define/SurvivalEnum.lua

module("modules.logic.survival.define.SurvivalEnum", package.seeall)

local SurvivalEnum = _M

SurvivalEnum.RainType = {
	Rain3 = 2,
	Rain2 = 3,
	Rain1 = 1
}
SurvivalEnum.UnitType = {
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
SurvivalEnum.UnitSubType = {
	Water = 96,
	Shop = 77,
	Ice = 95,
	Magma = 94,
	Miasma = 92,
	Morass = 93,
	BlockEvent = 791,
	Block = 91
}
SurvivalEnum.Dir = {
	BottomRight = 1,
	TopLeft = 4,
	Right = 0,
	TopRight = 5,
	BottomLeft = 2,
	Left = 3
}
SurvivalEnum.DirToPos = {
	[SurvivalEnum.Dir.Right] = SurvivalHexNode.New(1, 0, -1),
	[SurvivalEnum.Dir.BottomRight] = SurvivalHexNode.New(0, 1, -1),
	[SurvivalEnum.Dir.BottomLeft] = SurvivalHexNode.New(-1, 1, 0),
	[SurvivalEnum.Dir.Left] = SurvivalHexNode.New(-1, 0, 1),
	[SurvivalEnum.Dir.TopLeft] = SurvivalHexNode.New(0, -1, 1),
	[SurvivalEnum.Dir.TopRight] = SurvivalHexNode.New(1, -1, 0)
}
SurvivalEnum.ConstId = {
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
SurvivalEnum.HardUnlockCondition = {
	overDifMult = "passMods",
	overDif = "overDif"
}
SurvivalEnum.OperType = {
	PlayerMove = 1,
	SelectOption = 5,
	TriggerEvent = 2,
	OperSearch = 3,
	FightBack = 6
}
SurvivalEnum.StepRunOrder = {
	Before = 1,
	After = 3,
	None = 2
}
SurvivalEnum.StepType = {
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
SurvivalEnum.MagmaStatus = {
	Intermittent = 2,
	Active = 0,
	Normal = 1
}
SurvivalEnum.PanelType = {
	TreeEvent = 2,
	Store = 4,
	DropSelect = 3,
	Search = 1,
	Decrees = 5,
	None = 0
}
SurvivalEnum.FightStatu = {
	Win = 1,
	Lose = 2,
	None = 0
}
SurvivalEnum.ItemType = {
	Quick = 5,
	Equip = 7,
	Pileup = 8,
	NPC = 6,
	DecreeSelect = 10,
	Reputation = 9,
	Material = 1,
	Currency = 2
}
SurvivalEnum.CurrencyType = {
	Gold = 1,
	Enthusiastic = 4,
	Decoding = 5,
	Food = 3,
	Build = 2
}
SurvivalEnum.ItemSubType = {
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
SurvivalEnum.CustomUseItemSubType = {
	[SurvivalEnum.ItemSubType.Quick_Fly] = true,
	[SurvivalEnum.ItemSubType.Quick_ClearFog] = true,
	[SurvivalEnum.ItemSubType.Quick_SwapPos] = true,
	[SurvivalEnum.ItemSubType.Quick_DelObstructNPCFight] = true,
	[SurvivalEnum.ItemSubType.Quick_TransferToEvent] = true,
	[SurvivalEnum.ItemSubType.Quick_TransferUnitOut] = true
}
SurvivalEnum.ItemSource = {
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
SurvivalEnum.HelpState = {
	Full = 3,
	UnSelected = 2,
	Selected = 1
}
SurvivalEnum.GameTimeUpdateReason = {
	Cost = 2,
	Normal = 1
}
SurvivalEnum.MapResult = {
	Win = 1,
	Lose = 2,
	None = 0
}
SurvivalEnum.MapSettleReason = {
	HealthLimit = 1,
	Abort = 3,
	TimeLimit = 2,
	UseItem = 4,
	Success = 0
}
SurvivalEnum.StepTypeToName = {}

for k, v in pairs(SurvivalEnum.StepType) do
	SurvivalEnum.StepTypeToName[v] = k
end

SurvivalEnum.UnitTypeToName = {}

for k, v in pairs(SurvivalEnum.UnitType) do
	SurvivalEnum.UnitTypeToName[v] = k
end

SurvivalEnum.BuildingStatus = {
	Destroy = 1,
	Normal = 0
}
SurvivalEnum.HeroStatu = {
	HasBuff = 1,
	Hurt = 2,
	Normal = 0
}
SurvivalEnum.NpcStatus = {
	HomeBreak = 2,
	OutSide = 1,
	HomeLess = 3,
	Normal = 0
}
SurvivalEnum.EventChoiceIcon = {
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
SurvivalEnum.IconToColor = {
	[SurvivalEnum.EventChoiceIcon.None] = SurvivalConst.EventChoiceColor.Yellow,
	[SurvivalEnum.EventChoiceIcon.Task] = SurvivalConst.EventChoiceColor.Green,
	[SurvivalEnum.EventChoiceIcon.NPC] = SurvivalConst.EventChoiceColor.Green,
	[SurvivalEnum.EventChoiceIcon.Search] = SurvivalConst.EventChoiceColor.Green,
	[SurvivalEnum.EventChoiceIcon.Treasure] = SurvivalConst.EventChoiceColor.Green,
	[SurvivalEnum.EventChoiceIcon.Fight] = SurvivalConst.EventChoiceColor.Red,
	[SurvivalEnum.EventChoiceIcon.FightElite] = SurvivalConst.EventChoiceColor.Red,
	[SurvivalEnum.EventChoiceIcon.Exit] = SurvivalConst.EventChoiceColor.Yellow,
	[SurvivalEnum.EventChoiceIcon.Obstruct] = SurvivalConst.EventChoiceColor.Yellow,
	[SurvivalEnum.EventChoiceIcon.Talk] = SurvivalConst.EventChoiceColor.Yellow,
	[SurvivalEnum.EventChoiceIcon.Return] = SurvivalConst.EventChoiceColor.Yellow
}
SurvivalEnum.ItemSortType = {
	ItemReward = 8,
	EquipTag = 5,
	Time = 4,
	Type = 3,
	Worth = 2,
	Result = 7,
	NPC = 6,
	Mass = 1
}
SurvivalEnum.ItemFilterType = {
	Equip = 2,
	Material = 1,
	Consume = 3
}
SurvivalEnum.TaskStatus = {
	Done = 2,
	Doing = 1,
	Fail = 4,
	Finish = 3
}
SurvivalEnum.TaskModule = {
	StoryTask = 3,
	MainTask = 1,
	MapMainTarget = 5,
	SubTask = 2,
	NormalTask = 4
}
SurvivalEnum.AttrType = {
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
SurvivalEnum.AttrTypePer = {
	[SurvivalEnum.AttrType.BuyPriceFix] = true,
	[SurvivalEnum.AttrType.SellPriceFix] = true,
	[SurvivalEnum.AttrType.BuildBuyPriceFix] = true,
	[SurvivalEnum.AttrType.BuildSellPriceFix] = true,
	[SurvivalEnum.AttrType.HealthDec] = true,
	[SurvivalEnum.AttrType.HealthInc] = true,
	[SurvivalEnum.AttrType.NpcRecruitment] = true,
	[SurvivalEnum.AttrType.ChoiceCostTime] = true,
	[SurvivalEnum.AttrType.BuildCost] = true,
	[SurvivalEnum.AttrType.RepairCost] = true,
	[SurvivalEnum.AttrType.NpcFoodCost] = true,
	[SurvivalEnum.AttrType.ShopBuyPriceFix] = true,
	[SurvivalEnum.AttrType.MapSellPriceFix] = true,
	[SurvivalEnum.AttrType.RenownChangeFix] = true,
	[SurvivalEnum.AttrType.DecodingFix] = true
}
SurvivalEnum.PlayerMoveReason = {
	Fly = 4,
	Transfer = 3,
	Tornado = 5,
	Swap = 6,
	Back = 2,
	Summon = 7,
	Normal = 1
}
SurvivalEnum.UnitDeadReason = {
	DieByQuickItem = 2006,
	PlayDieAnim = 2003
}
SurvivalEnum.NpcRecruitmentType = {
	NpcNumCheck = 3,
	WorthCheck = 4,
	FinishTask = 5,
	FinishEvent = 6,
	ItemCost = 1,
	ItemCheck = 2
}
SurvivalEnum.ConditionOper = {
	GE = 1,
	LE = 3,
	EQ = 2
}
SurvivalEnum.BuildingType = {
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
SurvivalEnum.InfoShowType = {
	Npc = 2,
	Building = 1,
	NpcOnlyConfig = 3,
	None = 0
}
SurvivalEnum.ShelterNpcStatus = {
	NotInBuild = 0,
	InDestoryBuild = 2,
	InBuild = 1,
	OutSide = 3
}
SurvivalEnum.ShelterUnitType = {
	Monster = 3,
	VoteEntity = 5,
	Player = 4,
	Npc = 1,
	Build = 2
}
SurvivalEnum.ShelterMonsterFightState = {
	Fighting = 2,
	Abandon = 4,
	Fail = 3,
	NoStart = 1,
	Win = 5
}
SurvivalEnum.ShelterUnitTypeToName = {}

for k, v in pairs(SurvivalEnum.ShelterUnitType) do
	SurvivalEnum.ShelterUnitTypeToName[v] = k
end

SurvivalEnum.ShelterBuildingBtnStatus = {
	Destroy = 1,
	New = 3,
	Levelup = 2,
	Normal = 0
}
SurvivalEnum.ShelterDecreeStatus = {
	UnFinish = 1,
	Finish = 2,
	Normal = 0
}
SurvivalEnum.ShelterBtnUnlockType = {
	BuildingTypeLev = 1
}
SurvivalEnum.ShelterGridType = {
	Triangle = 2,
	Single = 1
}
SurvivalEnum.NpcSubType = {
	Story = 52,
	Normal = 51
}
SurvivalEnum.SurvivalIntrudeAbandonBlock = "SurvivalIntrudeAbandonBlock"
SurvivalEnum.ShelterBuildingLocalStatus = {
	Destroy = 1,
	NormalToDestroy = 102,
	DestroyToNormal = 101,
	UnBuildToNormal = 103,
	BaseStatus = 100,
	UnBuild = 2,
	Normal = 0
}
SurvivalEnum.SurvivalMonsterEventViewShowType = {
	Watch = 1,
	Normal = 0
}
SurvivalEnum.HandBookType = {
	Amplifier = 2,
	Result = 4,
	Event = 3,
	Npc = 1
}
SurvivalEnum.HandBookTypeToName = {}

for name, index in pairs(SurvivalEnum.HandBookType) do
	SurvivalEnum.HandBookTypeToName[index] = name
end

SurvivalEnum.HandBookEventSubType = {
	Fight = 2,
	Task = 3,
	Search = 1
}
SurvivalEnum.HandBookAmplifierSubType = {
	Common = 1,
	Bloom = 4,
	ElectricEnergy = 2,
	ExtraActions = 5,
	Ceremony = 6,
	Revelation = 3,
	StateAbnormal = 7
}
SurvivalEnum.HandBookAmplifierSubTypeUIPos = {
	SurvivalEnum.HandBookAmplifierSubType.Common,
	SurvivalEnum.HandBookAmplifierSubType.Bloom,
	SurvivalEnum.HandBookAmplifierSubType.ElectricEnergy,
	SurvivalEnum.HandBookAmplifierSubType.Revelation,
	SurvivalEnum.HandBookAmplifierSubType.Ceremony,
	SurvivalEnum.HandBookAmplifierSubType.ExtraActions,
	SurvivalEnum.HandBookAmplifierSubType.StateAbnormal
}
SurvivalEnum.HandBookNpcSubType = {
	Foundation = 3,
	People = 1,
	Laplace = 2,
	Zeno = 4
}
SurvivalEnum.ReputationType = {
	Zeno = 2,
	People = 1,
	Laplace = 4,
	Foundation = 3
}
SurvivalEnum.ShopType = {
	Reputation = 2,
	PreExplore = 3,
	GeneralShop = 4,
	Normal = 1
}

return SurvivalEnum
