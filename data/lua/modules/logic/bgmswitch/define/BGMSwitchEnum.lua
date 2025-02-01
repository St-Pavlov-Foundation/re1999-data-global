module("modules.logic.bgmswitch.define.BGMSwitchEnum", package.seeall)

slot0 = _M
slot0.PlayMode = {
	LoopOne = 2,
	Random = 1,
	None = 0
}
slot0.PlayingState = {
	FoldPlaying = 1,
	UnfoldPlaying = 2,
	None = 0
}
slot0.Gear = {
	On2 = 2,
	OFF = 0,
	On1 = 1,
	On3 = 3
}
slot0.BGMDetailShowType = {
	Introduce = 2,
	Comment = 3,
	Progress = 1,
	None = 0
}
slot0.SelectType = {
	All = 0,
	Loved = 1
}
slot0.EasterEggType = {
	Beat = 1,
	Ppt = 2
}
slot0.RecordInfoType = {
	SwitchEgg = 2,
	BGMSwitchGear = 3,
	ListType = 1
}
slot0.BGMGuideId = 19401

return slot0
