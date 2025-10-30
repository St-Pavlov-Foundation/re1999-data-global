module("modules.logic.versionactivity3_0.karong.define.KaRongDrawEnum", package.seeall)

local var_0_0 = _M

var_0_0.dir = {
	down = -2,
	up = 2,
	left = -1,
	right = 1
}
var_0_0.mazeDrawWidth = 7
var_0_0.mazeDrawHeight = 4
var_0_0.mazeUIGridWidth = 205
var_0_0.mazeUIGridHeight = 205
var_0_0.mazeUILineWidth = 176
var_0_0.mazeUILineHorizonUIWidth = 204
var_0_0.mazeUILineVerticalUIWidth = 204
var_0_0.mazeMonsterHeight = 75
var_0_0.mazeMonsterTouchOffsetX = 0
var_0_0.MazeObjType = {
	CheckPoint = 4,
	End = 2,
	Start = 1,
	Block = 3
}
var_0_0.MazeObjSubType = {
	Two = 2,
	Default = 1,
	Three = 3
}
var_0_0.MazeAlertBlockOffsetX, var_0_0.MazeAlertBlockOffsetY = 90.8, 48.5
var_0_0.MazeAlertCrossOffsetX, var_0_0.MazeAlertCrossOffsetY = 25.3, 33.1
var_0_0.MazeMonsterIconOffset = {
	x = 0,
	y = 50
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
	Dialog = 1,
	AddSkill = 5,
	PopView = 4
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
