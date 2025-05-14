module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.define.PuzzleEnum", package.seeall)

local var_0_0 = _M

var_0_0.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
var_0_0.mazeDrawWidth = 4
var_0_0.mazeDrawHeight = 3
var_0_0.mazeUIGridWidth = 204
var_0_0.mazeUIGridHeight = 204
var_0_0.mazeUILineWidth = 176
var_0_0.mazeUILineHorizonUIWidth = 204
var_0_0.mazeUILineVerticalUIWidth = 204
var_0_0.mazeMonsterHeight = 102
var_0_0.mazeMonsterTouchOffsetX = 0
var_0_0.MazeObjType = {
	End = 2,
	Switch = 5,
	CheckPoint = 4,
	Start = 1,
	Block = 3
}
var_0_0.MazeObjSubType = {
	Default = 1
}
var_0_0.MazeAlertBlockOffsetX, var_0_0.MazeAlertBlockOffsetY = 90.8, 48.5
var_0_0.MazeAlertCrossOffsetX, var_0_0.MazeAlertCrossOffsetY = 25.3, 33.1
var_0_0.MazePawnPath = {
	"ui_maze_pawn",
	3.1,
	65.5
}
var_0_0.MazeMonsterIconOffset = {
	x = 0,
	y = 70.4
}
var_0_0.MazeAlertResPath = "ui_maze_alert"
var_0_0.AnimEvent_OnJump = "OnJump"
var_0_0.MazeAlertType = {
	VisitBlock = 1,
	VisitRepeat = 2,
	DisconnectLine = 3,
	None = 0
}
var_0_0.LineType = {
	Path = 2,
	Map = 1
}
var_0_0.LineState = {
	Disconnect = 1,
	Switch_On = 3,
	Connect = 0,
	Switch_Off = 2
}
var_0_0.PositionType = {
	Line = 2,
	Point = 1
}
var_0_0.EffectType = {
	Guide = 3,
	Story = 2,
	Dialog = 1
}
var_0_0.InteractIndexIcon = {
	"bianhao_a",
	"bianhao_b",
	"bianhao_c",
	"bianhao_d",
	"bianhao_e"
}
var_0_0.GameResult = {
	Abort = 3,
	Restart = 4,
	Failed = 2,
	Success = 1
}

return var_0_0
