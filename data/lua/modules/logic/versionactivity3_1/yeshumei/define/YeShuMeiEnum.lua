module("modules.logic.versionactivity3_1.yeshumei.define.YeShuMeiEnum", package.seeall)

local var_0_0 = _M

var_0_0.PointType = {
	Disturb = 2,
	Start = 3,
	Normal = 1
}
var_0_0.PointTypeName = {
	"普通点",
	"干扰点",
	"起点"
}
var_0_0.StateType = {
	Connect = 2,
	Error = 3,
	Normal = 1
}
var_0_0.LevelType = {
	Game = 2,
	Story = 1
}
var_0_0.BeForePlayGame = 1000
var_0_0.AfterPlayGame = 1001
var_0_0.ReViewTime = 1002
var_0_0.ConnectRange = 1003
var_0_0.CreateLineLength = 60

return var_0_0
