module("modules.logic.dungeon.defines.DungeonMazeEnum", package.seeall)

local var_0_0 = _M

var_0_0.WordTxtInterval = 5
var_0_0.WordTxtOpen = 0.7
var_0_0.WordTxtIdle = 1.1
var_0_0.WordTxtClose = 0.5
var_0_0.dir = {
	up = 4,
	down = 3,
	left = 1,
	right = 2
}
var_0_0.skillState = {
	cooling = 3,
	usable = 1,
	using = 2
}
var_0_0.resultStat = {
	"成功",
	"失败",
	"主动中断",
	"重置"
}
var_0_0.hideDialogTimeConstId = 2
var_0_0.MaxChaosValue = 100

return var_0_0
