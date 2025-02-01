module("modules.logic.chessgame.defines.ChessGameEnum", package.seeall)

slot0 = _M
slot0.NodeXOffset = 1.259
slot0.NodeYOffset = 0.804
slot0.NodeZOffset = 0.005
slot0.NodePath = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab"
slot0.SceneResPath = {
	AlarmItem3 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_red.prefab",
	DirItem = "scenes/v2a1_m_s12_lsp_jshd/prefab/diban_selected.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	AlarmItem2 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_yellow.prefab"
}
slot0.InteractType = {
	Hit = 4,
	Teleport = 3,
	Obstacle = 8,
	Prey = 7,
	Role = 2,
	Hunter = 6,
	Save = 5,
	Normal = 1
}
slot0.ChessSelectType = {
	CatchObj = 2,
	Normal = 1
}
slot0.ClickRangeX = 90
slot0.ClickRangeY = 55
slot0.ClickYWeight = 1.2
slot0.TileShowSettings = {
	width = 152.7,
	height = 54.6,
	offsetYX = 24.6,
	offsetY = -103.2,
	offsetX = 154.8,
	offsetXY = -29.3
}
slot0.GameEventType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
slot0.OptType = {
	WithInteract = 1,
	Single = 0,
	UseItem = 2
}
slot0.GameEffectType = {
	Display = 2,
	Talk = 1,
	None = 0
}
slot0.EffectPath = {
	[slot0.GameEffectType.Display] = "scenes/v2a1_m_s12_lsp_jshd/prefab/hudong.prefab",
	[slot0.GameEffectType.Talk] = "scenes/v2a1_m_s12_lsp_jshd/prefab/duihua.prefab"
}
slot0.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1,
	HpLimit = 3,
	InteractAllFinish = 4
}
slot0.TileBaseType = {
	Normal = 1,
	None = 0
}
slot0.InteractTypeToName = {}

for slot4, slot5 in pairs(slot0.InteractType) do
	slot0.InteractTypeToName[slot5] = slot4
end

slot0.EventType = {
	Hide = 4,
	Story = 2,
	Finish = 9,
	Guide = 3,
	ChangeModel = 10,
	Show = 5,
	Count = 1,
	Dialog = 6,
	Pass = 7,
	MoveOther = 11,
	Dead = 8
}
slot0.StepType = {
	Pass = 8,
	ChangeModule = 13,
	Talk = 16,
	CurrMapRefresh = 4,
	Completed = 11,
	ShowInteract = 12,
	InteractDelete = 5,
	RefreshTarget = 17,
	Transport = 3,
	Dead = 9,
	Story = 6,
	Guide = 7,
	ShowToast = 14,
	UpdateRound = 1,
	BreakObstacle = 15,
	Dialogue = 10,
	Move = 2
}
slot0.StepTypeToName = {}

for slot4, slot5 in pairs(slot0.StepType) do
	slot0.StepTypeToName[slot5] = slot4
end

slot0.ContainerOffsetZ = {
	Interact = -2,
	Background = -0.5,
	TipArea = -1,
	Path = -1.5
}
slot0.SelectPosStatus = {
	CatchObj = 3,
	SelectObjWaitPos = 2,
	ShowTalk = 4,
	None = 1
}
slot0.Direction = {
	Down = 2,
	Up = 8,
	Left = 4,
	Right = 6
}
slot0.RollBack = {
	LastPoint = 1,
	CheckPoint = 0
}
slot0.GameState = {
	Fail = 2,
	Win = 1
}
slot0.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1,
	HpLimit = 3,
	InteractAllFinish = 4
}
slot0.CloseAnimTime = 0.5
slot0.TitleOpenAnimTime = 2.5

return slot0
