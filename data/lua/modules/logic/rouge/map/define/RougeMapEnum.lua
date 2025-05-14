module("modules.logic.rouge.map.define.RougeMapEnum", package.seeall)

local var_0_0 = _M

var_0_0.RedNodeResPath = "ui/viewres/gm/rouge/red_point.prefab"
var_0_0.GreenNodeResPath = "ui/viewres/gm/rouge/green_point.prefab"
var_0_0.PathSelectLayerPath = "ui/viewres/gm/rouge/green_point.prefab"
var_0_0.LineResPath = "ui/viewres/gm/rouge/line_local.prefab"
var_0_0.ActorPiecePath = "v1a9_m_s16_saide"
var_0_0.CollectionLeftItemRes = "ui/viewres/rouge/map/rougecollectionleftitem.prefab"
var_0_0.CollectionRightItemRes = "ui/viewres/rouge/map/rougecollectionrightitem.prefab"
var_0_0.ChapterId = 2901
var_0_0.ConstKey = {
	ShowNormalFightUnlockTalentId = 32,
	ShowEliteFightUnlockTalentId = 31,
	RestStoreRefreshCount = 13,
	EliteFightDropRefreshUnlockTalentId = 34,
	HardFightDropRefreshUnlockTalentId = 36,
	ExchangeCount = 19,
	PathSelectCameraSize = 17,
	HardFightDropRefreshCount = 37,
	ShowHardFightUnlockTalentId = 33,
	FightRetryNum = 43,
	RestStoreUnlockTalentId = 30,
	EliteFightDropRefreshCount = 35,
	StoreRefreshCost = 21
}
var_0_0.PathSelectIndex = -1
var_0_0.MapState = {
	Normal = 4,
	SwitchMapAnim = 1,
	LoadingMap = 2,
	WaitFlow = 3,
	Empty = 0
}
var_0_0.MapType = {
	Edit = 0,
	Middle = 2,
	PathSelect = 3,
	Normal = 1
}
var_0_0.MapType2ModelCls = {
	[var_0_0.MapType.Normal] = RougeLayerMapModel,
	[var_0_0.MapType.Middle] = RougeMiddleLayerMapModel,
	[var_0_0.MapType.PathSelect] = RougePathSelectMapModel
}
var_0_0.ChangeMapEnum = {
	PathSelectToNormal = 3,
	MiddleToPathSelect = 2,
	NormalToMiddle = 1
}
var_0_0.ScenePrefabFormat = "scenes/v1a9_m_s16_dilao/prefab/%s.prefab"
var_0_0.Arrive = {
	CantArrive = 1,
	CanArrive = 3,
	ArrivingFinish = 5,
	Arrived = 6,
	NotArrive = 2,
	ArrivingNotFinish = 4
}
var_0_0.NodeSelectArriveStatus = var_0_0.Arrive.ArrivingNotFinish
var_0_0.EventType = {
	Reward = 5,
	HardFight = 2,
	BossFight = 4,
	Rest = 8,
	Unknow = 13,
	ChoiceLair = 11,
	NormalFight = 1,
	Choice = 6,
	FightLair = 12,
	Store = 7,
	WatchTower = 9,
	LevelUpSp = 14,
	TreasurePlace = 10,
	EliteFight = 3,
	Empty = 0
}
var_0_0.EventDefaultPic = {
	[var_0_0.EventType.NormalFight] = "rouge_map_detailmap_01",
	[var_0_0.EventType.HardFight] = "rouge_map_detailmap_02",
	[var_0_0.EventType.EliteFight] = "rouge_map_detailmap_03",
	[var_0_0.EventType.Reward] = "rouge_map_detailmap_04",
	[var_0_0.EventType.Choice] = "rouge_map_detailmap_05",
	[var_0_0.EventType.Store] = "rouge_map_detailmap_06",
	[var_0_0.EventType.Rest] = "rouge_map_detailmap_07",
	[var_0_0.EventType.WatchTower] = "rouge_map_detailmap_08",
	[var_0_0.EventType.TreasurePlace] = "rouge_map_detailmap_09",
	[var_0_0.EventType.ChoiceLair] = "rouge_map_detailmap_10",
	[var_0_0.EventType.FightLair] = "rouge_map_detailmap_10",
	[var_0_0.EventType.Unknow] = "rouge_map_detailmap_11",
	[var_0_0.EventType.LevelUpSp] = "rouge_map_detailmap_12"
}
var_0_0.PicFormat = "singlebg/rouge/mapdetail/%s.png"
var_0_0.MonsterMaskFormat = "singlebg/rouge/mapdetail/monster/%s.png"
var_0_0.EventType2Cls = {
	[var_0_0.EventType.Reward] = RougeChoiceEventMO,
	[var_0_0.EventType.Choice] = RougeChoiceEventMO,
	[var_0_0.EventType.Rest] = RougeChoiceEventMO,
	[var_0_0.EventType.Store] = RougeStoreEventMO,
	[var_0_0.EventType.NormalFight] = RougeFightEventMO,
	[var_0_0.EventType.HardFight] = RougeFightEventMO,
	[var_0_0.EventType.EliteFight] = RougeFightEventMO,
	[var_0_0.EventType.BossFight] = RougeFightEventMO,
	[var_0_0.EventType.WatchTower] = RougeChoiceEventMO,
	[var_0_0.EventType.TreasurePlace] = RougeChoiceEventMO,
	[var_0_0.EventType.ChoiceLair] = RougeChoiceEventMO,
	[var_0_0.EventType.FightLair] = RougeFightEventMO,
	[var_0_0.EventType.Unknow] = RougeChoiceEventMO,
	[var_0_0.EventType.LevelUpSp] = RougeChoiceEventMO
}
var_0_0.NodeType = {
	End = 3,
	Start = 1,
	Normal = 2
}
var_0_0.EventState = {
	Finish = 2,
	Start = 1,
	Init = 0
}
var_0_0.IconPath = {
	[var_0_0.EventType.NormalFight] = "icon_normal_fight",
	[var_0_0.EventType.HardFight] = "icon_hard_fight",
	[var_0_0.EventType.EliteFight] = "icon_elite_fight",
	[var_0_0.EventType.Reward] = "icon_reward",
	[var_0_0.EventType.Choice] = "icon_choice",
	[var_0_0.EventType.Store] = "icon_store",
	[var_0_0.EventType.Rest] = "icon_rest",
	[var_0_0.EventType.WatchTower] = "icon_8",
	[var_0_0.EventType.TreasurePlace] = "icon_9",
	[var_0_0.EventType.ChoiceLair] = "icon_10",
	[var_0_0.EventType.FightLair] = "icon_10",
	[var_0_0.EventType.Unknow] = "icon_11",
	[var_0_0.EventType.LevelUpSp] = "icon_12"
}
var_0_0.StartNodeBgPath = "bg_start"
var_0_0.NodeBgPath = {
	Normal = {
		[var_0_0.Arrive.CantArrive] = "bg_normal_cant_arrive",
		[var_0_0.Arrive.NotArrive] = "bg_normal_cant_arrive",
		[var_0_0.Arrive.CanArrive] = "bg_normal_can_arrive",
		[var_0_0.Arrive.ArrivingNotFinish] = "bg_normal_arriving_not_finish",
		[var_0_0.Arrive.ArrivingFinish] = "bg_normal_arriving_finish",
		[var_0_0.Arrive.Arrived] = "bg_normal_arrived"
	},
	Special = {
		[var_0_0.Arrive.CantArrive] = "bg_special_cant_arrive",
		[var_0_0.Arrive.NotArrive] = "bg_special_cant_arrive",
		[var_0_0.Arrive.CanArrive] = "bg_special_can_arrive",
		[var_0_0.Arrive.ArrivingNotFinish] = "bg_special_arriving_not_finish",
		[var_0_0.Arrive.ArrivingFinish] = "bg_special_arriving_finish",
		[var_0_0.Arrive.Arrived] = "bg_special_arrived"
	}
}
var_0_0.FogMaterialUrl = "scenes/v1a9_m_s16_dilao/scene_prefab/v2a1_smoke_mask.prefab"
var_0_0.MaxHoleNum = 5
var_0_0.HoleSize = -1.21
var_0_0.FogDuration = 1
var_0_0.NormalLineCutValue = 0
var_0_0.HideLineCutValue = 1
var_0_0.FogLineCutValue = 0.4
var_0_0.HoleLineCutValue = 0.85
var_0_0.FogOffset = {
	-4,
	0
}
var_0_0.HolePosOffset = {
	0,
	0.18
}
var_0_0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
var_0_0.MiddleLayerPointType = {
	Leave = 3,
	Pieces = 1,
	Path = 2
}
var_0_0.LeaveId = -1
var_0_0.LeaveAnchorOffset = Vector2(-21, 77.7)
var_0_0.OffsetZ = {
	PiecesContainer = -7,
	PieceIcon = -8,
	NodeContainer = -2,
	PathContainer = -6,
	Map = 10
}
var_0_0.NodeOffsetZInterval = 0.1
var_0_0.NodeIconOffsetZInterval = 0.5
var_0_0.Scale = {
	Icon = 1.3,
	NodeBg = 1.3
}
var_0_0.MapStartOffsetX = 2.5
var_0_0.NodeLocalPosXRange = 1
var_0_0.NodeLocalPosY = {
	{
		0.5
	},
	{
		0.4,
		0.6
	},
	{
		0.3,
		0.5,
		0.7
	},
	{
		0.2,
		0.4,
		0.6,
		0.8
	}
}
var_0_0.NodeGlobalOffsetY = 0.075
var_0_0.StartBgOffset = Vector2(0, 0)
var_0_0.NodeBgOffset = {
	[var_0_0.Arrive.CantArrive] = Vector2(0, 0),
	[var_0_0.Arrive.NotArrive] = Vector2(0, 0),
	[var_0_0.Arrive.CanArrive] = Vector2(0.23, 0.84),
	[var_0_0.Arrive.ArrivingNotFinish] = Vector2(0.188, 1.739),
	[var_0_0.Arrive.ArrivingFinish] = Vector2(0.204, 1.77),
	[var_0_0.Arrive.Arrived] = Vector2(0.195, 0.86)
}
var_0_0.IconOffset = {
	[var_0_0.Arrive.CantArrive] = Vector2(0, 0.47),
	[var_0_0.Arrive.NotArrive] = Vector2(0, 0.47),
	[var_0_0.Arrive.CanArrive] = Vector2(0, 1.2),
	[var_0_0.Arrive.ArrivingNotFinish] = Vector2(0, 2.02),
	[var_0_0.Arrive.ArrivingFinish] = Vector2(0, 2.18),
	[var_0_0.Arrive.Arrived] = Vector2(0, 1.21)
}
var_0_0.ActorOffset = Vector2(-0.05, 0.623)
var_0_0.StartClickArea = Vector4(80, 50, 0, 0)
var_0_0.ClickArea = {
	[var_0_0.Arrive.CantArrive] = Vector4(120, 100, 0.66, 14.09),
	[var_0_0.Arrive.NotArrive] = Vector4(120, 110, 1.55, 26.89),
	[var_0_0.Arrive.CanArrive] = Vector4(200, 170, -12.65, -26.41),
	[var_0_0.Arrive.ArrivingNotFinish] = Vector4(235, 330, -8.14, -22.11),
	[var_0_0.Arrive.ArrivingFinish] = Vector4(236, 345, -7.95, -5.48),
	[var_0_0.Arrive.Arrived] = Vector4(160, 190, -13.62, -11.17)
}
var_0_0.LeaveItemClickArea = Vector4(320.29, 184.6, -18.2, 78.39)
var_0_0.LayerItemClickArea = Vector4(120, 100, 0, 0)
var_0_0.PieceClickArea = Vector4(120, 270, 0, 49.42)
var_0_0.ChoiceItemPos = {
	{
		Vector2(29.7, 10.8)
	},
	{
		Vector2(70, 146),
		Vector2(20.38, -126.4)
	},
	{
		Vector2(-48, 240),
		Vector2(120, -6),
		Vector2(-48, -245.2)
	},
	{
		Vector2(-48, 298.3),
		Vector2(120, 67.9),
		Vector2(-12, -155),
		Vector2(-88, -382)
	}
}
var_0_0.ChoiceStatus = {
	UnSelect = 5,
	Bought = 4,
	Select = 3,
	Lock = 1,
	Normal = 2
}
var_0_0.PieceChoiceViewStatus = {
	Store = 2,
	Choice = 1
}
var_0_0.DialogueOffsetX = {
	WithChoice = -172.8,
	Normal = 0
}
var_0_0.DialogueInterval = 0.05
var_0_0.InteractType = {
	Recruit = 5,
	LossCollection = 2,
	ReturnBlood = 3,
	Drop = 1,
	DropGroup = 6,
	LossAndCopy = 7,
	LossNotUniqueCollection = 9,
	LossCoin = 11,
	LossSpCollection = 14,
	LevelUpSp = 13,
	AdvanceDrop = 12,
	Resurgence = 4,
	StorageCollection = 10,
	LossAssignCollection = 8
}
var_0_0.ReturnBloodEnum = {
	All = 1,
	Select = 2
}
var_0_0.ShowMapRightEnum = {
	Piece = 3,
	Node = 1,
	Layer = 2
}
var_0_0.PieceEntrustType = {
	Hard = 3,
	Rest = 1,
	Boss = 5,
	Ending = 4,
	Normal = 2
}
var_0_0.MiddleLayerLeavePath = "scenes/v1a9_m_s16_dilao_room/prefab/chukou.prefab"
var_0_0.PieceIconBgEnum = {
	Hard = 2,
	Normal = 1
}
var_0_0.PieceIconBgRes = {
	[var_0_0.PieceIconBgEnum.Normal] = "scenes/v1a9_m_s16_dilao_room/prefab/yuanjian_di.prefab",
	[var_0_0.PieceIconBgEnum.Hard] = "scenes/v1a9_m_s16_dilao_room/prefab/yuanjian_di2.prefab"
}
var_0_0.PieceIconRes = {
	[var_0_0.PieceEntrustType.Rest] = "scenes/v1a9_m_s16_dilao_room/prefab/xiuzheng.prefab",
	[var_0_0.PieceEntrustType.Normal] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_1.prefab",
	[var_0_0.PieceEntrustType.Hard] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_2.prefab",
	[var_0_0.PieceEntrustType.Ending] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_jieju.prefab"
}
var_0_0.PieceIconBg = {
	[var_0_0.PieceEntrustType.Rest] = var_0_0.PieceIconBgEnum.Normal,
	[var_0_0.PieceEntrustType.Normal] = var_0_0.PieceIconBgEnum.Normal,
	[var_0_0.PieceEntrustType.Hard] = var_0_0.PieceIconBgEnum.Hard,
	[var_0_0.PieceEntrustType.Ending] = var_0_0.PieceIconBgEnum.Normal
}
var_0_0.PieceIconOffset = Vector2(0, 1.65)
var_0_0.PieceTriggerType = {
	Compound = 3,
	Shop = 4,
	Reward = 2,
	EndFight = 6,
	Exchange = 5,
	AcceptEntrust = 1,
	LevelUpSp = 7,
	Empty = 0
}
var_0_0.MiddleLayerCameraSizeRate = 0.8
var_0_0.PathSelectMapWaitTime = 1
var_0_0.LossType = {
	Storage = 3,
	Abandon = 1,
	Exchange = 2,
	Copy = 4,
	AbandonSp = 5
}
var_0_0.LineType = {
	Arrived = 4,
	CanArrive = 3,
	NotArrive = 2,
	CantArrive = 1,
	None = 0
}
var_0_0.LinePrefabRes = "scenes/v1a9_m_s16_dilao/prefab/dituxian_1.prefab"
var_0_0.LineIconRes = {
	[var_0_0.LineType.CantArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_1.png",
	[var_0_0.LineType.NotArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_2.png",
	[var_0_0.LineType.CanArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_3.png",
	[var_0_0.LineType.Arrived] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_4.png"
}
var_0_0.StatusLineMap = {
	[var_0_0.Arrive.CantArrive] = {
		[var_0_0.Arrive.CantArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.NotArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.CanArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.ArrivingNotFinish] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.ArrivingFinish] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.Arrived] = var_0_0.LineType.CantArrive
	},
	[var_0_0.Arrive.NotArrive] = {
		[var_0_0.Arrive.CantArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.NotArrive] = var_0_0.LineType.NotArrive,
		[var_0_0.Arrive.CanArrive] = var_0_0.LineType.NotArrive,
		[var_0_0.Arrive.ArrivingNotFinish] = var_0_0.LineType.NotArrive,
		[var_0_0.Arrive.ArrivingFinish] = var_0_0.LineType.CanArrive,
		[var_0_0.Arrive.Arrived] = var_0_0.LineType.None
	},
	[var_0_0.Arrive.CanArrive] = {
		[var_0_0.Arrive.CantArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.NotArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.CanArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingNotFinish] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingFinish] = var_0_0.LineType.CanArrive,
		[var_0_0.Arrive.Arrived] = var_0_0.LineType.None
	},
	[var_0_0.Arrive.ArrivingNotFinish] = {
		[var_0_0.Arrive.CantArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.NotArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.CanArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingNotFinish] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingFinish] = var_0_0.LineType.Arrived,
		[var_0_0.Arrive.Arrived] = var_0_0.LineType.Arrived
	},
	[var_0_0.Arrive.ArrivingFinish] = {
		[var_0_0.Arrive.CantArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.NotArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.CanArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingNotFinish] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingFinish] = var_0_0.LineType.Arrived,
		[var_0_0.Arrive.Arrived] = var_0_0.LineType.Arrived
	},
	[var_0_0.Arrive.Arrived] = {
		[var_0_0.Arrive.CantArrive] = var_0_0.LineType.CantArrive,
		[var_0_0.Arrive.NotArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.CanArrive] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingNotFinish] = var_0_0.LineType.None,
		[var_0_0.Arrive.ArrivingFinish] = var_0_0.LineType.Arrived,
		[var_0_0.Arrive.Arrived] = var_0_0.LineType.Arrived
	}
}
var_0_0.LineOffset = 0.636
var_0_0.CollectionDropViewEnum = {
	Select = 1,
	OnlyShow = 2
}
var_0_0.RevertDuration = 0.4
var_0_0.MoveSpeed = 7
var_0_0.CameraTweenLine = EaseType.OutCubic
var_0_0.TipShowDuration = 2.5
var_0_0.TipShowInterval = 0.5
var_0_0.DayOrNight = {
	Day = 1,
	Night = 2
}
var_0_0.DayOrNightSuffix = {
	[var_0_0.DayOrNight.Day] = "day",
	[var_0_0.DayOrNight.Night] = "night"
}
var_0_0.PieceDir = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
var_0_0.ActorDir = {
	Bottom = 2,
	Right = 6,
	LeftBottom = 1,
	RightTop = 9,
	Top = 8,
	RightBottom = 3,
	Left = 4,
	LeftTop = 7
}
var_0_0.EntrustEventType = {
	Curse = 4,
	LevelUpSpCollection = 9,
	Event = 3,
	MakeMoney = 1,
	CostMoney = 2,
	FinishEvent = 7,
	MakePower = 6,
	GetCollection = 8,
	CostPower = 5
}
var_0_0.FinishEnum = {
	Finish = 1,
	Fail = 2
}
var_0_0.UnSelectLineAlpha = 0.3
var_0_0.SwitchLayerMinDuration = 3
var_0_0.SwitchLayerMaxDuration = 10
var_0_0.CoinChangeDuration = 1
var_0_0.PowerChangeDuration = 1
var_0_0.TalkAnchorOffset = {
	[var_0_0.MapType.Normal] = Vector2(0, 31.46),
	[var_0_0.MapType.Middle] = Vector2(0, 73.34)
}
var_0_0.TalkDuration = 2
var_0_0.TalkCD = 5
var_0_0.ShortVoiceTriggerType = {
	EnterPathSelectLayer = 3,
	FinishEvent = 6,
	EnterMiddleLayer = 2,
	MiddleLayerMove = 8,
	EnterNormalLayer = 1,
	AcceptEntrust = 5,
	NormalLayerMove = 7,
	ExitPieceTalk = 4
}
var_0_0.ChoiceSelectAnimDuration = 0.667
var_0_0.EffectType = {
	UnlockFightDropRefresh = 23,
	UnlockRestRefresh = 21,
	UpdateExchangeDisplaceNum = 28,
	UnlockShowPassFightMask = 26
}
var_0_0.ExpAddDuration = 0.5
var_0_0.WaitSuccAnimDuration = 2
var_0_0.WaitSuccPlayAudioDuration = 1
var_0_0.WaitSwitchMapAnim = 0.33
var_0_0.SwitchMapAnimDuration = 1.33
var_0_0.WaitStoryCloseAnim = 1
var_0_0.PieceBossEffect = "scenes/v1a9_m_s16_dilao_room/scene_prefab/chesseffect/luoleilai_effect.prefab"
var_0_0.MaxTipHeight = 924
var_0_0.CollectionChangeAnimDuration = 0.5
var_0_0.LifeChangeStatus = {
	Add = 3,
	Reduce = 1,
	Idle = 2
}
var_0_0.WaitStoreRefreshAnimDuration = 0.2
var_0_0.WaitMapRightRefreshTime = 0.16
var_0_0.ScrollPosition = {
	Top = 1,
	Bottom = 0
}
var_0_0.ChoiceViewState = {
	Finish = 3,
	PlayingDialogue = 1,
	WaitSelect = 2
}
var_0_0.WaitChoiceItemAnimBlock = "WaitChoiceItemAnimBlock"
var_0_0.EntrustStatus = {
	Brief = 1,
	Detail = 2
}
var_0_0.ChangeEntrustTime = 3
var_0_0.FinishEntrustEffect = 3
var_0_0.WaitMiddleLayerEnterTime = 0.5
var_0_0.MovingBlock = "ActorMovingBlock"
var_0_0.StoreGoodsDescHeight = {
	NoHole = 400,
	WithHole = 247
}

return var_0_0
