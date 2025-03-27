module("modules.logic.rouge.map.define.RougeMapEnum", package.seeall)

slot0 = _M
slot0.RedNodeResPath = "ui/viewres/gm/rouge/red_point.prefab"
slot0.GreenNodeResPath = "ui/viewres/gm/rouge/green_point.prefab"
slot0.PathSelectLayerPath = "ui/viewres/gm/rouge/green_point.prefab"
slot0.LineResPath = "ui/viewres/gm/rouge/line_local.prefab"
slot0.ActorPiecePath = "v1a9_m_s16_saide"
slot0.CollectionLeftItemRes = "ui/viewres/rouge/map/rougecollectionleftitem.prefab"
slot0.CollectionRightItemRes = "ui/viewres/rouge/map/rougecollectionrightitem.prefab"
slot0.ChapterId = 2901
slot0.ConstKey = {
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
slot0.PathSelectIndex = -1
slot0.MapState = {
	Normal = 4,
	SwitchMapAnim = 1,
	LoadingMap = 2,
	WaitFlow = 3,
	Empty = 0
}
slot0.MapType = {
	Edit = 0,
	Middle = 2,
	PathSelect = 3,
	Normal = 1
}
slot0.MapType2ModelCls = {
	[slot0.MapType.Normal] = RougeLayerMapModel,
	[slot0.MapType.Middle] = RougeMiddleLayerMapModel,
	[slot0.MapType.PathSelect] = RougePathSelectMapModel
}
slot0.ChangeMapEnum = {
	PathSelectToNormal = 3,
	MiddleToPathSelect = 2,
	NormalToMiddle = 1
}
slot0.ScenePrefabFormat = "scenes/v1a9_m_s16_dilao/prefab/%s.prefab"
slot0.Arrive = {
	CantArrive = 1,
	CanArrive = 3,
	ArrivingFinish = 5,
	Arrived = 6,
	NotArrive = 2,
	ArrivingNotFinish = 4
}
slot0.NodeSelectArriveStatus = slot0.Arrive.ArrivingNotFinish
slot0.EventType = {
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
slot0.EventDefaultPic = {
	[slot0.EventType.NormalFight] = "rouge_map_detailmap_01",
	[slot0.EventType.HardFight] = "rouge_map_detailmap_02",
	[slot0.EventType.EliteFight] = "rouge_map_detailmap_03",
	[slot0.EventType.Reward] = "rouge_map_detailmap_04",
	[slot0.EventType.Choice] = "rouge_map_detailmap_05",
	[slot0.EventType.Store] = "rouge_map_detailmap_06",
	[slot0.EventType.Rest] = "rouge_map_detailmap_07",
	[slot0.EventType.WatchTower] = "rouge_map_detailmap_08",
	[slot0.EventType.TreasurePlace] = "rouge_map_detailmap_09",
	[slot0.EventType.ChoiceLair] = "rouge_map_detailmap_10",
	[slot0.EventType.FightLair] = "rouge_map_detailmap_10",
	[slot0.EventType.Unknow] = "rouge_map_detailmap_11",
	[slot0.EventType.LevelUpSp] = "rouge_map_detailmap_12"
}
slot0.PicFormat = "singlebg/rouge/mapdetail/%s.png"
slot0.MonsterMaskFormat = "singlebg/rouge/mapdetail/monster/%s.png"
slot0.EventType2Cls = {
	[slot0.EventType.Reward] = RougeChoiceEventMO,
	[slot0.EventType.Choice] = RougeChoiceEventMO,
	[slot0.EventType.Rest] = RougeChoiceEventMO,
	[slot0.EventType.Store] = RougeStoreEventMO,
	[slot0.EventType.NormalFight] = RougeFightEventMO,
	[slot0.EventType.HardFight] = RougeFightEventMO,
	[slot0.EventType.EliteFight] = RougeFightEventMO,
	[slot0.EventType.BossFight] = RougeFightEventMO,
	[slot0.EventType.WatchTower] = RougeChoiceEventMO,
	[slot0.EventType.TreasurePlace] = RougeChoiceEventMO,
	[slot0.EventType.ChoiceLair] = RougeChoiceEventMO,
	[slot0.EventType.FightLair] = RougeFightEventMO,
	[slot0.EventType.Unknow] = RougeChoiceEventMO,
	[slot0.EventType.LevelUpSp] = RougeChoiceEventMO
}
slot0.NodeType = {
	End = 3,
	Start = 1,
	Normal = 2
}
slot0.EventState = {
	Finish = 2,
	Start = 1,
	Init = 0
}
slot0.IconPath = {
	[slot0.EventType.NormalFight] = "icon_normal_fight",
	[slot0.EventType.HardFight] = "icon_hard_fight",
	[slot0.EventType.EliteFight] = "icon_elite_fight",
	[slot0.EventType.Reward] = "icon_reward",
	[slot0.EventType.Choice] = "icon_choice",
	[slot0.EventType.Store] = "icon_store",
	[slot0.EventType.Rest] = "icon_rest",
	[slot0.EventType.WatchTower] = "icon_8",
	[slot0.EventType.TreasurePlace] = "icon_9",
	[slot0.EventType.ChoiceLair] = "icon_10",
	[slot0.EventType.FightLair] = "icon_10",
	[slot0.EventType.Unknow] = "icon_11",
	[slot0.EventType.LevelUpSp] = "icon_12"
}
slot0.StartNodeBgPath = "bg_start"
slot0.NodeBgPath = {
	Normal = {
		[slot0.Arrive.CantArrive] = "bg_normal_cant_arrive",
		[slot0.Arrive.NotArrive] = "bg_normal_cant_arrive",
		[slot0.Arrive.CanArrive] = "bg_normal_can_arrive",
		[slot0.Arrive.ArrivingNotFinish] = "bg_normal_arriving_not_finish",
		[slot0.Arrive.ArrivingFinish] = "bg_normal_arriving_finish",
		[slot0.Arrive.Arrived] = "bg_normal_arrived"
	},
	Special = {
		[slot0.Arrive.CantArrive] = "bg_special_cant_arrive",
		[slot0.Arrive.NotArrive] = "bg_special_cant_arrive",
		[slot0.Arrive.CanArrive] = "bg_special_can_arrive",
		[slot0.Arrive.ArrivingNotFinish] = "bg_special_arriving_not_finish",
		[slot0.Arrive.ArrivingFinish] = "bg_special_arriving_finish",
		[slot0.Arrive.Arrived] = "bg_special_arrived"
	}
}
slot0.FogMaterialUrl = "scenes/v1a9_m_s16_dilao/scene_prefab/v2a1_smoke_mask.prefab"
slot0.MaxHoleNum = 5
slot0.HoleSize = -1.21
slot0.FogDuration = 1
slot0.NormalLineCutValue = 0
slot0.HideLineCutValue = 1
slot0.FogLineCutValue = 0.4
slot0.HoleLineCutValue = 0.85
slot0.FogOffset = {
	-4,
	0
}
slot0.HolePosOffset = {
	0,
	0.18
}
slot0.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
slot0.MiddleLayerPointType = {
	Leave = 3,
	Pieces = 1,
	Path = 2
}
slot0.LeaveId = -1
slot0.LeaveAnchorOffset = Vector2(-21, 77.7)
slot0.OffsetZ = {
	PiecesContainer = -7,
	PieceIcon = -8,
	NodeContainer = -2,
	PathContainer = -6,
	Map = 10
}
slot0.NodeOffsetZInterval = 0.1
slot0.NodeIconOffsetZInterval = 0.5
slot0.Scale = {
	Icon = 1.3,
	NodeBg = 1.3
}
slot0.MapStartOffsetX = 2.5
slot0.NodeLocalPosXRange = 1
slot0.NodeLocalPosY = {
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
slot0.NodeGlobalOffsetY = 0.075
slot0.StartBgOffset = Vector2(0, 0)
slot0.NodeBgOffset = {
	[slot0.Arrive.CantArrive] = Vector2(0, 0),
	[slot0.Arrive.NotArrive] = Vector2(0, 0),
	[slot0.Arrive.CanArrive] = Vector2(0.23, 0.84),
	[slot0.Arrive.ArrivingNotFinish] = Vector2(0.188, 1.739),
	[slot0.Arrive.ArrivingFinish] = Vector2(0.204, 1.77),
	[slot0.Arrive.Arrived] = Vector2(0.195, 0.86)
}
slot0.IconOffset = {
	[slot0.Arrive.CantArrive] = Vector2(0, 0.47),
	[slot0.Arrive.NotArrive] = Vector2(0, 0.47),
	[slot0.Arrive.CanArrive] = Vector2(0, 1.2),
	[slot0.Arrive.ArrivingNotFinish] = Vector2(0, 2.02),
	[slot0.Arrive.ArrivingFinish] = Vector2(0, 2.18),
	[slot0.Arrive.Arrived] = Vector2(0, 1.21)
}
slot0.ActorOffset = Vector2(-0.05, 0.623)
slot0.StartClickArea = Vector4(80, 50, 0, 0)
slot0.ClickArea = {
	[slot0.Arrive.CantArrive] = Vector4(120, 100, 0.66, 14.09),
	[slot0.Arrive.NotArrive] = Vector4(120, 110, 1.55, 26.89),
	[slot0.Arrive.CanArrive] = Vector4(200, 170, -12.65, -26.41),
	[slot0.Arrive.ArrivingNotFinish] = Vector4(235, 330, -8.14, -22.11),
	[slot0.Arrive.ArrivingFinish] = Vector4(236, 345, -7.95, -5.48),
	[slot0.Arrive.Arrived] = Vector4(160, 190, -13.62, -11.17)
}
slot0.LeaveItemClickArea = Vector4(320.29, 184.6, -18.2, 78.39)
slot0.LayerItemClickArea = Vector4(120, 100, 0, 0)
slot0.PieceClickArea = Vector4(120, 270, 0, 49.42)
slot0.ChoiceItemPos = {
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
slot0.ChoiceStatus = {
	UnSelect = 5,
	Bought = 4,
	Select = 3,
	Lock = 1,
	Normal = 2
}
slot0.PieceChoiceViewStatus = {
	Store = 2,
	Choice = 1
}
slot0.DialogueOffsetX = {
	WithChoice = -172.8,
	Normal = 0
}
slot0.DialogueInterval = 0.05
slot0.InteractType = {
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
slot0.ReturnBloodEnum = {
	All = 1,
	Select = 2
}
slot0.ShowMapRightEnum = {
	Piece = 3,
	Node = 1,
	Layer = 2
}
slot0.PieceEntrustType = {
	Hard = 3,
	Rest = 1,
	Boss = 5,
	Ending = 4,
	Normal = 2
}
slot0.MiddleLayerLeavePath = "scenes/v1a9_m_s16_dilao_room/prefab/chukou.prefab"
slot0.PieceIconBgEnum = {
	Hard = 2,
	Normal = 1
}
slot0.PieceIconBgRes = {
	[slot0.PieceIconBgEnum.Normal] = "scenes/v1a9_m_s16_dilao_room/prefab/yuanjian_di.prefab",
	[slot0.PieceIconBgEnum.Hard] = "scenes/v1a9_m_s16_dilao_room/prefab/yuanjian_di2.prefab"
}
slot0.PieceIconRes = {
	[slot0.PieceEntrustType.Rest] = "scenes/v1a9_m_s16_dilao_room/prefab/xiuzheng.prefab",
	[slot0.PieceEntrustType.Normal] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_1.prefab",
	[slot0.PieceEntrustType.Hard] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_2.prefab",
	[slot0.PieceEntrustType.Ending] = "scenes/v1a9_m_s16_dilao_room/prefab/chuanwen_jieju.prefab"
}
slot0.PieceIconBg = {
	[slot0.PieceEntrustType.Rest] = slot0.PieceIconBgEnum.Normal,
	[slot0.PieceEntrustType.Normal] = slot0.PieceIconBgEnum.Normal,
	[slot0.PieceEntrustType.Hard] = slot0.PieceIconBgEnum.Hard,
	[slot0.PieceEntrustType.Ending] = slot0.PieceIconBgEnum.Normal
}
slot0.PieceIconOffset = Vector2(0, 1.65)
slot0.PieceTriggerType = {
	Compound = 3,
	Shop = 4,
	Reward = 2,
	EndFight = 6,
	Exchange = 5,
	AcceptEntrust = 1,
	LevelUpSp = 7,
	Empty = 0
}
slot0.MiddleLayerCameraSizeRate = 0.8
slot0.PathSelectMapWaitTime = 1
slot0.LossType = {
	Storage = 3,
	Abandon = 1,
	Exchange = 2,
	Copy = 4,
	AbandonSp = 5
}
slot0.LineType = {
	Arrived = 4,
	CanArrive = 3,
	NotArrive = 2,
	CantArrive = 1,
	None = 0
}
slot0.LinePrefabRes = "scenes/v1a9_m_s16_dilao/prefab/dituxian_1.prefab"
slot0.LineIconRes = {
	[slot0.LineType.CantArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_1.png",
	[slot0.LineType.NotArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_2.png",
	[slot0.LineType.CanArrive] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_3.png",
	[slot0.LineType.Arrived] = "scenes/dynamic/rouge/texture/v1a9_m_s16_dilao_icon_a01_4.png"
}
slot0.StatusLineMap = {
	[slot0.Arrive.CantArrive] = {
		[slot0.Arrive.CantArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.NotArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.CanArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.ArrivingNotFinish] = slot0.LineType.CantArrive,
		[slot0.Arrive.ArrivingFinish] = slot0.LineType.CantArrive,
		[slot0.Arrive.Arrived] = slot0.LineType.CantArrive
	},
	[slot0.Arrive.NotArrive] = {
		[slot0.Arrive.CantArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.NotArrive] = slot0.LineType.NotArrive,
		[slot0.Arrive.CanArrive] = slot0.LineType.NotArrive,
		[slot0.Arrive.ArrivingNotFinish] = slot0.LineType.NotArrive,
		[slot0.Arrive.ArrivingFinish] = slot0.LineType.CanArrive,
		[slot0.Arrive.Arrived] = slot0.LineType.None
	},
	[slot0.Arrive.CanArrive] = {
		[slot0.Arrive.CantArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.NotArrive] = slot0.LineType.None,
		[slot0.Arrive.CanArrive] = slot0.LineType.None,
		[slot0.Arrive.ArrivingNotFinish] = slot0.LineType.None,
		[slot0.Arrive.ArrivingFinish] = slot0.LineType.CanArrive,
		[slot0.Arrive.Arrived] = slot0.LineType.None
	},
	[slot0.Arrive.ArrivingNotFinish] = {
		[slot0.Arrive.CantArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.NotArrive] = slot0.LineType.None,
		[slot0.Arrive.CanArrive] = slot0.LineType.None,
		[slot0.Arrive.ArrivingNotFinish] = slot0.LineType.None,
		[slot0.Arrive.ArrivingFinish] = slot0.LineType.Arrived,
		[slot0.Arrive.Arrived] = slot0.LineType.Arrived
	},
	[slot0.Arrive.ArrivingFinish] = {
		[slot0.Arrive.CantArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.NotArrive] = slot0.LineType.None,
		[slot0.Arrive.CanArrive] = slot0.LineType.None,
		[slot0.Arrive.ArrivingNotFinish] = slot0.LineType.None,
		[slot0.Arrive.ArrivingFinish] = slot0.LineType.Arrived,
		[slot0.Arrive.Arrived] = slot0.LineType.Arrived
	},
	[slot0.Arrive.Arrived] = {
		[slot0.Arrive.CantArrive] = slot0.LineType.CantArrive,
		[slot0.Arrive.NotArrive] = slot0.LineType.None,
		[slot0.Arrive.CanArrive] = slot0.LineType.None,
		[slot0.Arrive.ArrivingNotFinish] = slot0.LineType.None,
		[slot0.Arrive.ArrivingFinish] = slot0.LineType.Arrived,
		[slot0.Arrive.Arrived] = slot0.LineType.Arrived
	}
}
slot0.LineOffset = 0.636
slot0.CollectionDropViewEnum = {
	Select = 1,
	OnlyShow = 2
}
slot0.RevertDuration = 0.4
slot0.MoveSpeed = 7
slot0.CameraTweenLine = EaseType.OutCubic
slot0.TipShowDuration = 2.5
slot0.TipShowInterval = 0.5
slot0.DayOrNight = {
	Day = 1,
	Night = 2
}
slot0.DayOrNightSuffix = {
	[slot0.DayOrNight.Day] = "day",
	[slot0.DayOrNight.Night] = "night"
}
slot0.PieceDir = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
slot0.ActorDir = {
	Bottom = 2,
	Right = 6,
	LeftBottom = 1,
	RightTop = 9,
	Top = 8,
	RightBottom = 3,
	Left = 4,
	LeftTop = 7
}
slot0.EntrustEventType = {
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
slot0.FinishEnum = {
	Finish = 1,
	Fail = 2
}
slot0.UnSelectLineAlpha = 0.3
slot0.SwitchLayerMinDuration = 3
slot0.SwitchLayerMaxDuration = 10
slot0.CoinChangeDuration = 1
slot0.PowerChangeDuration = 1
slot0.TalkAnchorOffset = {
	[slot0.MapType.Normal] = Vector2(0, 31.46),
	[slot0.MapType.Middle] = Vector2(0, 73.34)
}
slot0.TalkDuration = 2
slot0.TalkCD = 5
slot0.ShortVoiceTriggerType = {
	EnterPathSelectLayer = 3,
	FinishEvent = 6,
	EnterMiddleLayer = 2,
	MiddleLayerMove = 8,
	EnterNormalLayer = 1,
	AcceptEntrust = 5,
	NormalLayerMove = 7,
	ExitPieceTalk = 4
}
slot0.ChoiceSelectAnimDuration = 0.667
slot0.EffectType = {
	UnlockFightDropRefresh = 23,
	UnlockRestRefresh = 21,
	UpdateExchangeDisplaceNum = 28,
	UnlockShowPassFightMask = 26
}
slot0.ExpAddDuration = 0.5
slot0.WaitSuccAnimDuration = 2
slot0.WaitSuccPlayAudioDuration = 1
slot0.WaitSwitchMapAnim = 0.33
slot0.SwitchMapAnimDuration = 1.33
slot0.WaitStoryCloseAnim = 1
slot0.PieceBossEffect = "scenes/v1a9_m_s16_dilao_room/scene_prefab/chesseffect/luoleilai_effect.prefab"
slot0.MaxTipHeight = 924
slot0.CollectionChangeAnimDuration = 0.5
slot0.LifeChangeStatus = {
	Add = 3,
	Reduce = 1,
	Idle = 2
}
slot0.WaitStoreRefreshAnimDuration = 0.2
slot0.WaitMapRightRefreshTime = 0.16
slot0.ScrollPosition = {
	Top = 1,
	Bottom = 0
}
slot0.ChoiceViewState = {
	Finish = 3,
	PlayingDialogue = 1,
	WaitSelect = 2
}
slot0.WaitChoiceItemAnimBlock = "WaitChoiceItemAnimBlock"
slot0.EntrustStatus = {
	Brief = 1,
	Detail = 2
}
slot0.ChangeEntrustTime = 3
slot0.FinishEntrustEffect = 3
slot0.WaitMiddleLayerEnterTime = 0.5
slot0.MovingBlock = "ActorMovingBlock"
slot0.StoreGoodsDescHeight = {
	NoHole = 400,
	WithHole = 247
}

return slot0
