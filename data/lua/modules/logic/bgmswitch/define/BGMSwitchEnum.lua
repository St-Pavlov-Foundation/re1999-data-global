module("modules.logic.bgmswitch.define.BGMSwitchEnum", package.seeall)

local var_0_0 = _M

var_0_0.PlayMode = {
	LoopOne = 2,
	Random = 1,
	None = 0
}
var_0_0.PlayingState = {
	FoldPlaying = 1,
	UnfoldPlaying = 2,
	None = 0
}
var_0_0.Gear = {
	On2 = 2,
	OFF = 0,
	On1 = 1,
	On3 = 3
}
var_0_0.BGMDetailShowType = {
	Introduce = 2,
	Comment = 3,
	Progress = 1,
	None = 0
}
var_0_0.SelectType = {
	All = 0,
	Loved = 1
}
var_0_0.EasterEggType = {
	Beat = 1,
	Ppt = 2
}
var_0_0.RecordInfoType = {
	SwitchEgg = 2,
	BGMSwitchGear = 3,
	ListType = 1
}
var_0_0.BGMGuideId = 19401

return var_0_0
