module("modules.logic.versionactivity1_2.yaxian.define.YaXianGameEnum", package.seeall)

local var_0_0 = YaXianEnum

var_0_0.TileBaseType = {
	Normal = 1,
	None = 0
}
var_0_0.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
var_0_0.TileSetting = {
	baffleOffsetX = 0.64,
	height = 1.619276,
	width = 2.563867,
	baffleOffsetY = 0.44
}
var_0_0.TileSetting.halfWidth = var_0_0.TileSetting.width / 2
var_0_0.TileSetting.halfHeight = var_0_0.TileSetting.height / 2
var_0_0.InteractType = {
	PickUpItem = 7,
	TriggerFail = 5,
	Enemy = 4,
	Player = 1,
	Item = 3,
	TriggerVictory = 6,
	Obstacle = 2,
	NoEffectItem = 8
}
var_0_0.MoveDirection = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
var_0_0.OppositeDirection = {
	[var_0_0.MoveDirection.Bottom] = var_0_0.MoveDirection.Top,
	[var_0_0.MoveDirection.Left] = var_0_0.MoveDirection.Right,
	[var_0_0.MoveDirection.Right] = var_0_0.MoveDirection.Left,
	[var_0_0.MoveDirection.Top] = var_0_0.MoveDirection.Bottom
}
var_0_0.BaffleDirection = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
var_0_0.DirectionName = {
	[var_0_0.MoveDirection.Bottom] = "down",
	[var_0_0.MoveDirection.Left] = "left",
	[var_0_0.MoveDirection.Right] = "right",
	[var_0_0.MoveDirection.Top] = "up"
}
var_0_0.BaffleDirectionPowerPos = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
var_0_0.BaffleType = {
	Second = 2,
	First = 1
}
var_0_0.ClickRangeX = 125
var_0_0.ClickRangeY = 80
var_0_0.ClickYWeight = 1.2
var_0_0.ChessBoardOffsetX = -7.85
var_0_0.ChessBoardOffsetY = -0.2
var_0_0.InteractSelectPriority = {
	[var_0_0.InteractType.Player] = 1
}
var_0_0.GameStateType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
var_0_0.GameStepType = {
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
var_0_0.SkillId = {
	InVisible = 1,
	ThroughWall = 2
}
var_0_0.SkillType = {
	InVisible = 1,
	ThroughWall = 2
}
var_0_0.ConditionType = {
	FinishAllInteract = 3,
	FinishInteract = 2,
	PassEpisode = 0,
	Round = 1
}
var_0_0.SceneResPath = {
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
var_0_0.InteractHeight = {
	[10001] = 1,
	[10006] = 1
}
var_0_0.MinShowPriority = 0
var_0_0.InteractShowPriority = {
	[var_0_0.InteractType.TriggerVictory] = 1,
	[var_0_0.InteractType.Enemy] = 2,
	[var_0_0.InteractType.Player] = 3
}
var_0_0.IconStatus = {
	Fight = 2,
	Assassinate = 1,
	PlayerAssassinate = 5,
	ThroughWall = 4,
	InVisible = 3
}
var_0_0.DirectionIcon = {
	[var_0_0.IconStatus.PlayerAssassinate] = true,
	[var_0_0.IconStatus.Fight] = true
}
var_0_0.AIType = {
	NotLoop = 2,
	Loop = 1
}
var_0_0.AlertType = {
	SingleWay = 1,
	FourWay = 3
}
var_0_0.ContainerOffsetZ = {
	Interact = -2,
	Background = -0.5,
	TipArea = -1,
	Path = -1.5
}
var_0_0.AlertOffsetZ = -0.01
var_0_0.EffectType = {
	Fight = 1,
	Die = 3,
	Assassinate = 2,
	FightSuccess = 4,
	PlayerAssassinateEffect = 5
}
var_0_0.DefaultEffectDuration = 0.5
var_0_0.EffectDuration = {
	[var_0_0.EffectType.Die] = 0.8,
	[var_0_0.EffectType.FightSuccess] = 1.2
}
var_0_0.MoveDuration = 0.3
var_0_0.SmallMoveDuration = 0.2
var_0_0.IconAnimationSwitchInterval = 1
var_0_0.IconAnimationDuration = 0.333
var_0_0.StopAnimationDuration = 0.333
var_0_0.InteractAnimationName = {
	TwoEffect = "skill_two_open",
	TwoEffectClose = "skill_two_close",
	CloseInVisible = "skill_ys_close",
	ThroughWall = "skill_cq_open",
	InVisible = "skill_ys_open",
	Die = "die",
	CloseThroughWall = "skill_cq_close"
}
var_0_0.CloseAnimationName = {
	[var_0_0.InteractAnimationName.InVisible] = var_0_0.InteractAnimationName.CloseInVisible,
	[var_0_0.InteractAnimationName.ThroughWall] = var_0_0.InteractAnimationName.CloseThroughWall,
	[var_0_0.InteractAnimationName.TwoEffect] = var_0_0.InteractAnimationName.TwoEffectClose
}
var_0_0.InteractDefaultTopPosOffset = Vector3(0, 1.04, 0)
var_0_0.ResultSimageName = {
	FightFail = "img_zi1",
	RoundUseUp = "img_zi3",
	Success = "img_zi2"
}
var_0_0.EndTxtAnchorY = {
	HadTxt = Vector2(0.5, 0.2),
	NoneTxt = Vector2(0.5, 0.5)
}
var_0_0.DeleteInteractReason = {
	AssassinateKill = 1,
	FightKill = 3,
	Win = 2
}
var_0_0.LastEpisodeId = 21
var_0_0.BossInteractId = 30501
var_0_0.FakeBossStartPos = {
	posY = 3,
	posX = 0
}
var_0_0.FakeBossDirection = var_0_0.MoveDirection.Right
var_0_0.StepFinishDelay = 0.3
var_0_0.ScenePosYRange = {
	Max = 10,
	Min = -10
}
var_0_0.ScenePosYRangeArea = var_0_0.ScenePosYRange.Max - var_0_0.ScenePosYRange.Min
var_0_0.LevelScenePosZRange = {
	Max = 0,
	Min = -0.4
}
var_0_0.SwitchDirectionDelay = 0.15
var_0_0.EffectInterval = 1

return var_0_0
