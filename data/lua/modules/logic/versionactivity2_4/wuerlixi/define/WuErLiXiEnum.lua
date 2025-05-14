module("modules.logic.versionactivity2_4.wuerlixi.define.WuErLiXiEnum", package.seeall)

local var_0_0 = _M

var_0_0.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
var_0_0.Dir = {
	Down = 2,
	Up = 0,
	Right = 1,
	Left = 3
}
var_0_0.UnitType = {
	Reflection = 5,
	KeyStart = 2,
	Obstacle = 4,
	SignalStart = 1,
	Switch = 7,
	SignalMulti = 6,
	SignalEnd = 3,
	Key = 8
}
var_0_0.UnitTypeToName = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.UnitType) do
	var_0_0.UnitTypeToName[iter_0_1] = iter_0_0
end

var_0_0.NodeType = {
	Placeable = 1,
	UnPlaceable = 2
}
var_0_0.RayType = {
	SwitchSignal = 2,
	NormalSignal = 1
}
var_0_0.GameMapNodeWidth = 84

return var_0_0
