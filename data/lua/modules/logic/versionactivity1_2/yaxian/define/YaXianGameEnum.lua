module("modules.logic.versionactivity1_2.yaxian.define.YaXianGameEnum", package.seeall)

slot0 = YaXianEnum
slot0.TileBaseType = {
	Normal = 1,
	None = 0
}
slot0.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
slot0.TileSetting = {
	baffleOffsetX = 0.64,
	height = 1.619276,
	width = 2.563867,
	baffleOffsetY = 0.44
}
slot0.TileSetting.halfWidth = slot0.TileSetting.width / 2
slot0.TileSetting.halfHeight = slot0.TileSetting.height / 2
slot0.InteractType = {
	PickUpItem = 7,
	TriggerFail = 5,
	Enemy = 4,
	Player = 1,
	Item = 3,
	TriggerVictory = 6,
	Obstacle = 2,
	NoEffectItem = 8
}
slot0.MoveDirection = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
slot0.OppositeDirection = {
	[slot0.MoveDirection.Bottom] = slot0.MoveDirection.Top,
	[slot0.MoveDirection.Left] = slot0.MoveDirection.Right,
	[slot0.MoveDirection.Right] = slot0.MoveDirection.Left,
	[slot0.MoveDirection.Top] = slot0.MoveDirection.Bottom
}
slot0.BaffleDirection = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
slot0.DirectionName = {
	[slot0.MoveDirection.Bottom] = "down",
	[slot0.MoveDirection.Left] = "left",
	[slot0.MoveDirection.Right] = "right",
	[slot0.MoveDirection.Top] = "up"
}
slot0.BaffleDirectionPowerPos = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
slot0.BaffleType = {
	Second = 2,
	First = 1
}
slot0.ClickRangeX = 125
slot0.ClickRangeY = 80
slot0.ClickYWeight = 1.2
slot0.ChessBoardOffsetX = -7.85
slot0.ChessBoardOffsetY = -0.2
slot0.InteractSelectPriority = {
	[slot0.InteractType.Player] = 1
}
slot0.GameStateType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
slot0.GameStepType = {
	GameFinish = 2,
	CallEvent = 4,
	DeleteObject = 6,
	CreateObject = 5,
	InteractFinish = 8,
	PickUp = 7,
	NextRound = 1,
	UpdateObjectData = 9,
	Move = 3
}
slot0.SkillId = {
	InVisible = 1,
	ThroughWall = 2
}
slot0.SkillType = {
	InVisible = 1,
	ThroughWall = 2
}
slot0.ConditionType = {
	FinishAllInteract = 3,
	FinishInteract = 2,
	PassEpisode = 0,
	Round = 1
}
slot0.SceneResPath = {
	GreedLineHalf = "scenes/m_s12_dfw_yaxian/prefab/tou_green.prefab",
	LRBaffle1 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_r_b_1x1.prefab",
	FightEffect = "scenes/m_s12_dfw_yaxian/prefab/yanxian_zhandou.prefab",
	LRBaffle0 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_r_a_1x1.prefab",
	RedLine = "scenes/m_s12_dfw_yaxian/prefab/line_red.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	ExitDefaultPath = "scenes/m_s12_dfw_yaxian/prefab/picpe/interact_exit.prefab",
	RedLineHalf = "scenes/m_s12_dfw_yaxian/prefab/tou_red.prefab",
	SceneFormatPath = "scenes/m_s12_dfw_yaxian/prefab/%s.prefab",
	AssassinateEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_ansha.prefab",
	GroundItem = "scenes/m_s12_dfw_yaxian/prefab/m_s12_diban_1x1_b.prefab",
	PlayerAssassinateEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_dead.prefab",
	TBBaffle0 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_l_a_1x1.prefab",
	GreenLine = "scenes/m_s12_dfw_yaxian/prefab/line_green.prefab",
	TBBaffle1 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_l_b_1x1.prefab",
	DefaultScene = "scenes/m_s12_dfw_yaxian/prefab/m_s12_yaxian_a_01_p.prefab",
	FightSuccessEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_win.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DieEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_die.prefab",
	MonsterStatus = "scenes/m_s12_dfw_yaxian/prefab/picpe/yaxian_icon.prefab",
	TargetItem = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_diban_mubiao.prefab"
}
slot0.InteractHeight = {
	[10001.0] = 1,
	[10006.0] = 1
}
slot0.MinShowPriority = 0
slot0.InteractShowPriority = {
	[slot0.InteractType.TriggerVictory] = 1,
	[slot0.InteractType.Enemy] = 2,
	[slot0.InteractType.Player] = 3
}
slot0.IconStatus = {
	Fight = 2,
	Assassinate = 1,
	PlayerAssassinate = 5,
	ThroughWall = 4,
	InVisible = 3
}
slot0.DirectionIcon = {
	[slot0.IconStatus.PlayerAssassinate] = true,
	[slot0.IconStatus.Fight] = true
}
slot0.AIType = {
	NotLoop = 2,
	Loop = 1
}
slot0.AlertType = {
	SingleWay = 1,
	FourWay = 3
}
slot0.ContainerOffsetZ = {
	Interact = -2,
	Background = -0.5,
	TipArea = -1,
	Path = -1.5
}
slot0.AlertOffsetZ = -0.01
slot0.EffectType = {
	Fight = 1,
	Die = 3,
	Assassinate = 2,
	FightSuccess = 4,
	PlayerAssassinateEffect = 5
}
slot0.DefaultEffectDuration = 0.5
slot0.EffectDuration = {
	[slot0.EffectType.Die] = 0.8,
	[slot0.EffectType.FightSuccess] = 1.2
}
slot0.MoveDuration = 0.3
slot0.SmallMoveDuration = 0.2
slot0.IconAnimationSwitchInterval = 1
slot0.IconAnimationDuration = 0.333
slot0.StopAnimationDuration = 0.333
slot0.InteractAnimationName = {
	TwoEffect = "skill_two_open",
	TwoEffectClose = "skill_two_close",
	CloseInVisible = "skill_ys_close",
	ThroughWall = "skill_cq_open",
	InVisible = "skill_ys_open",
	Die = "die",
	CloseThroughWall = "skill_cq_close"
}
slot0.CloseAnimationName = {
	[slot0.InteractAnimationName.InVisible] = slot0.InteractAnimationName.CloseInVisible,
	[slot0.InteractAnimationName.ThroughWall] = slot0.InteractAnimationName.CloseThroughWall,
	[slot0.InteractAnimationName.TwoEffect] = slot0.InteractAnimationName.TwoEffectClose
}
slot0.InteractDefaultTopPosOffset = Vector3(0, 1.04, 0)
slot0.ResultSimageName = {
	FightFail = "img_zi1",
	RoundUseUp = "img_zi3",
	Success = "img_zi2"
}
slot0.EndTxtAnchorY = {
	HadTxt = Vector2(0.5, 0.2),
	NoneTxt = Vector2(0.5, 0.5)
}
slot0.DeleteInteractReason = {
	AssassinateKill = 1,
	FightKill = 3,
	Win = 2
}
slot0.LastEpisodeId = 21
slot0.BossInteractId = 30501
slot0.FakeBossStartPos = {
	posY = 3,
	posX = 0
}
slot0.FakeBossDirection = slot0.MoveDirection.Right
slot0.StepFinishDelay = 0.3
slot0.ScenePosYRange = {
	Max = 10,
	Min = -10
}
slot0.ScenePosYRangeArea = slot0.ScenePosYRange.Max - slot0.ScenePosYRange.Min
slot0.LevelScenePosZRange = {
	Max = 0,
	Min = -0.4
}
slot0.SwitchDirectionDelay = 0.15
slot0.EffectInterval = 1

return slot0
