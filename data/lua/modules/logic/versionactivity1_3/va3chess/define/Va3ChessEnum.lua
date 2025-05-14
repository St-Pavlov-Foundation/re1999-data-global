module("modules.logic.versionactivity1_3.va3chess.define.Va3ChessEnum", package.seeall)

local var_0_0 = _M

var_0_0.TileBaseType = {
	Normal = 1,
	None = 0
}
var_0_0.TileShowSettings = {
	width = 152.7,
	height = 54.6,
	offsetYX = 24.6,
	offsetY = -103.2,
	offsetX = 154.8,
	offsetXY = -29.3
}
var_0_0.InteractType = {
	Item = 3,
	PushedOnceBlock = 15,
	DestroyableItem = 14,
	DeductHpEnemy = 17,
	TriggerFail = 5,
	Trap = 13,
	PickUpItem = 7,
	TriggerInteract = 9,
	CollectCheckPoint = 16,
	NoEffectItem = 8,
	Enemy = 4,
	Obstacle = 2,
	AssistPlayer = 18,
	BoltLauncher = 21,
	StandbyTrackEnemy = 24,
	Brazier = 23,
	PushedBlock = 12,
	Pedal = 22,
	SentryEnemy = 25,
	TriggerVictory = 6,
	Player = 1,
	DestroyableTrap = 20,
	NextMap = 11
}
var_0_0.Direction = {
	Down = 2,
	Up = 8,
	Left = 4,
	Right = 6
}
var_0_0.InteractParamType = {
	Story = 4
}
var_0_0.EffectType = {
	ArrowHit = 1
}
var_0_0.EffectPath = {
	[var_0_0.EffectType.ArrowHit] = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_jian_hit.prefab"
}
var_0_0.ScenePosZRange = {
	Max = -0.2,
	Min = 0
}
var_0_0.InteractSelectPriority = {
	[var_0_0.InteractType.Player] = 1,
	[var_0_0.InteractType.AssistPlayer] = 1
}
var_0_0.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
var_0_0.GameEventType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
var_0_0.GameStepType = {
	MapUpdate = 14,
	NextRound = 1,
	CallEvent = 4,
	SyncInteractObj = 9,
	TargetUpdate = 15,
	DeleteObject = 6,
	NextMap = 12,
	RefreshPedalStatus = 20,
	Toast = 11,
	PickUp = 7,
	BulletUpdate = 16,
	HpUpdate = 13,
	GameFinish = 2,
	Story = 10,
	BrazierTrigger = 17,
	CreateObject = 5,
	InteractFinish = 8,
	Move = 3
}
var_0_0.GameEffectType = {
	Display = 5,
	Direction = 2,
	Sleep = 3,
	Hero = 1,
	Monster = 4
}
var_0_0.Act120StepType = {
	TilePosui = 13
}
var_0_0.Act142StepType = {
	TileBroken = 13,
	TileFragile = 19
}
var_0_0.DeleteReason = {
	Default = 0,
	MoveKill = 5,
	Change = 6,
	Falling = 1,
	EnemyKill = 2,
	Arrow = 3,
	FireBall = 4
}
var_0_0.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1,
	HpLimit = 3,
	InteractAllFinish = 4
}
var_0_0.ChessSelectType = {
	UseItem = 2,
	Normal = 1
}
var_0_0.ClickRangeX = 125
var_0_0.ClickRangeY = 80
var_0_0.ClickYWeight = 1.2
var_0_0.ChessBoardOffsetX = -785
var_0_0.ChessBoardOffsetY = -20
var_0_0.TaskTypeClearEpisode = "Act109Star"
var_0_0.SWITCH_OPEN_ANIM = "swopen"
var_0_0.GuideIDForSwitchButton = 747
var_0_0.ResOffsetXY = {
	pingzi_a = {
		0,
		-14.5
	}
}
var_0_0.SceneResPath = {
	SceneFormatPath = "%s.prefab",
	AlarmItem3 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_red.prefab",
	GroundItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab",
	AlarmItem2 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_yellow.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	AvatarItemPath = "%s.prefab",
	DefaultScene = "scenes/m_s12_dfw/prefab/m_s12_pikelesi_a_01_p.prefab"
}
var_0_0.FailReason = {
	CanNotMove = 2,
	MaxRound = 3,
	Battle = 1,
	FailInteract = 4,
	None = 0
}
var_0_0.Res2SortOrder = {
	jingcha_b = 1,
	chuandan_b = 9,
	youke_a = 7,
	pikelese_a = 3,
	["scenes/v1a5_m_s12_dfw_krd/perefab/jiguan"] = 3,
	wajueyishu_a = 5,
	jingcha_a = 1,
	anbaoyuan_a = 6,
	wendi_a = 2,
	pingzi_a = 8,
	pingguo_a = 4,
	chuandan_a = 10,
	interact_exit = 11
}
var_0_0.AlarmOrder = {
	AlarmItem = -100,
	DirItem = -150
}
var_0_0.ViewType = {
	Game = 1,
	Reward = 3,
	Result = 2
}
var_0_0.TileTrigger = {
	PoSui = 2,
	Broken = 3
}
var_0_0.TriggerStatus = {
	[var_0_0.TileTrigger.Broken] = {
		Broken = 3,
		Fragile = 2,
		Normal = 1
	}
}
var_0_0.ActivityId = {
	Act109 = 11103,
	Act122 = 11304,
	Act120 = 11306,
	Act142 = VersionActivity1_5Enum.ActivityId.Activity142
}
var_0_0.ObjState = {
	Idle = 1,
	Interoperable = 2
}
var_0_0.ComponentType = {
	Animator = typeof(UnityEngine.Animator),
	MeshRenderer = typeof(UnityEngine.MeshRenderer)
}
var_0_0.DEFAULT_BULLET_SPEED = 8
var_0_0.DEFAULT_BULLET_FLY_TIME = 1
var_0_0.Bullet = {
	Arrow = {
		speed = 8,
		path = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_jian.prefab"
	},
	FireBall = {
		speed = 8,
		path = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_fire_ball.prefab"
	}
}

return var_0_0
