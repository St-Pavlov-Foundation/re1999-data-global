module("modules.logic.activity.define.ActivityChessEnum", package.seeall)

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
	PickUpItem = 7,
	TriggerFail = 5,
	Enemy = 4,
	Player = 1,
	Item = 3,
	TriggerVictory = 6,
	Obstacle = 2,
	NoEffectItem = 8
}
var_0_0.InteractSelectPriority = {
	[var_0_0.InteractType.Player] = 1
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
	GameFinish = 2,
	CallEvent = 4,
	SyncInteractObj = 9,
	DeleteObject = 6,
	CreateObject = 5,
	InteractFinish = 8,
	PickUp = 7,
	NextRound = 1,
	Move = 3
}
var_0_0.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1
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
var_0_0.EpisodeId = 1160101
var_0_0.GuideIDForSwitchButton = 747
var_0_0.ResOffsetXY = {
	pingzi_a = {
		0,
		-14.5
	}
}
var_0_0.SceneResPath = {
	SceneFormatPath = "scenes/m_s12_dfw/prefab/%s.prefab",
	GroundItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DefaultScene = "scenes/m_s12_dfw/prefab/m_s12_pikelesi_a_01_p.prefab"
}
var_0_0.FailReason = {
	CanNotMove = 2,
	MaxRound = 3,
	Battle = 1,
	FailInteract = 4,
	None = 0
}
var_0_0.RoleAvatar = {
	WJYS = "wajueyishu_a",
	PKLS = "pikelese_a",
	Apple = "pingguo_a"
}
var_0_0.Res2SortOrder = {
	jingcha_b = 1,
	chuandan_b = 9,
	wendi_a = 2,
	pikelese_a = 3,
	interact_exit = 11,
	wajueyishu_a = 5,
	jingcha_a = 1,
	anbaoyuan_a = 6,
	youke_a = 7,
	pingzi_a = 8,
	pingguo_a = 4,
	chuandan_a = 10
}

return var_0_0
