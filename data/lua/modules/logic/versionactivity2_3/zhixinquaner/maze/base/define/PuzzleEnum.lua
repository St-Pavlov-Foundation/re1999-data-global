module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.define.PuzzleEnum", package.seeall)

slot0 = _M
slot0.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
slot0.mazeDrawWidth = 4
slot0.mazeDrawHeight = 3
slot0.mazeUIGridWidth = 204
slot0.mazeUIGridHeight = 204
slot0.mazeUILineWidth = 176
slot0.mazeUILineHorizonUIWidth = 204
slot0.mazeUILineVerticalUIWidth = 204
slot0.mazeMonsterHeight = 102
slot0.mazeMonsterTouchOffsetX = 0
slot0.MazeObjType = {
	End = 2,
	Switch = 5,
	CheckPoint = 4,
	Start = 1,
	Block = 3
}
slot0.MazeObjSubType = {
	Default = 1
}
slot0.MazeAlertBlockOffsetY = 48.5
slot0.MazeAlertBlockOffsetX = 90.8
slot0.MazeAlertCrossOffsetY = 33.1
slot0.MazeAlertCrossOffsetX = 25.3
slot0.MazePawnPath = {
	"ui_maze_pawn",
	3.1,
	65.5
}
slot0.MazeMonsterIconOffset = {
	x = 0,
	y = 70.4
}
slot0.MazeAlertResPath = "ui_maze_alert"
slot0.AnimEvent_OnJump = "OnJump"
slot0.MazeAlertType = {
	VisitBlock = 1,
	VisitRepeat = 2,
	DisconnectLine = 3,
	None = 0
}
slot0.LineType = {
	Path = 2,
	Map = 1
}
slot0.LineState = {
	Disconnect = 1,
	Switch_On = 3,
	Connect = 0,
	Switch_Off = 2
}
slot0.PositionType = {
	Line = 2,
	Point = 1
}
slot0.EffectType = {
	Guide = 3,
	Story = 2,
	Dialog = 1
}
slot0.InteractIndexIcon = {
	"bianhao_a",
	"bianhao_b",
	"bianhao_c",
	"bianhao_d",
	"bianhao_e"
}
slot0.GameResult = {
	Abort = 3,
	Restart = 4,
	Failed = 2,
	Success = 1
}

return slot0
