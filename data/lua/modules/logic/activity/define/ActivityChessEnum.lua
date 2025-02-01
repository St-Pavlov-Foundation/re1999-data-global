module("modules.logic.activity.define.ActivityChessEnum", package.seeall)

slot0 = _M
slot0.TileBaseType = {
	Normal = 1,
	None = 0
}
slot0.TileShowSettings = {
	width = 152.7,
	height = 54.6,
	offsetYX = 24.6,
	offsetY = -103.2,
	offsetX = 154.8,
	offsetXY = -29.3
}
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
slot0.InteractSelectPriority = {
	[slot0.InteractType.Player] = 1
}
slot0.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
slot0.GameEventType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
slot0.GameStepType = {
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
slot0.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1
}
slot0.ChessSelectType = {
	UseItem = 2,
	Normal = 1
}
slot0.ClickRangeX = 125
slot0.ClickRangeY = 80
slot0.ClickYWeight = 1.2
slot0.ChessBoardOffsetX = -785
slot0.ChessBoardOffsetY = -20
slot0.TaskTypeClearEpisode = "Act109Star"
slot0.EpisodeId = 1160101
slot0.GuideIDForSwitchButton = 747
slot0.ResOffsetXY = {
	pingzi_a = {
		0,
		-14.5
	}
}
slot0.SceneResPath = {
	SceneFormatPath = "scenes/m_s12_dfw/prefab/%s.prefab",
	GroundItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DefaultScene = "scenes/m_s12_dfw/prefab/m_s12_pikelesi_a_01_p.prefab"
}
slot0.FailReason = {
	CanNotMove = 2,
	MaxRound = 3,
	Battle = 1,
	FailInteract = 4,
	None = 0
}
slot0.RoleAvatar = {
	WJYS = "wajueyishu_a",
	PKLS = "pikelese_a",
	Apple = "pingguo_a"
}
slot0.Res2SortOrder = {
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

return slot0
