module("modules.logic.versionactivity2_4.wuerlixi.define.WuErLiXiEnum", package.seeall)

slot0 = _M
slot0.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
slot0.Dir = {
	Down = 2,
	Up = 0,
	Right = 1,
	Left = 3
}
slot0.UnitType = {
	Reflection = 5,
	KeyStart = 2,
	Obstacle = 4,
	SignalStart = 1,
	Switch = 7,
	SignalMulti = 6,
	SignalEnd = 3,
	Key = 8
}
slot0.UnitTypeToName = {}

for slot4, slot5 in pairs(slot0.UnitType) do
	slot0.UnitTypeToName[slot5] = slot4
end

slot0.NodeType = {
	Placeable = 1,
	UnPlaceable = 2
}
slot0.RayType = {
	SwitchSignal = 2,
	NormalSignal = 1
}
slot0.GameMapNodeWidth = 84

return slot0
