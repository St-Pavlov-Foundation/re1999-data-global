module("modules.logic.versionactivity2_5.liangyue.define.LiangYueEnum", package.seeall)

local var_0_0 = _M

var_0_0.MeshItemColor = {
	Common = "#FFFFFF",
	Disable = "#FF1800",
	Enable = "#65B96F"
}
var_0_0.ScrollItemColor = {
	Enough = "FFFFFF",
	NotEnought = "C8C8C8"
}
var_0_0.CalculateType = {
	Minus = 2,
	Divide = 4,
	Add = 1,
	Multiply = 3
}
var_0_0.CalculateSymbol = {
	"+",
	"-",
	"×",
	"÷"
}
var_0_0.MonthEn = {
	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December"
}
var_0_0.TweenDuration = 0.2
var_0_0.DragAlpha = 0.5
var_0_0.NormalAlpha = 1
var_0_0.MeshAlpha = 0.5
var_0_0.AttributeType = {
	TwoColumn = 2,
	OneRow = 3,
	OneColumn = 1
}
var_0_0.StatGameState = {
	Finish = "成功",
	Restart = "重新开始",
	Exit = "中断"
}
var_0_0.UnlimitedSign = "∞"
var_0_0.AttributeOffset = 35
var_0_0.EpisodeAnim = {
	Finish = "finish",
	FinishIdle = "finish_idle",
	Unlock = "unlock",
	Empty = "empty"
}
var_0_0.EpisodeGameAnim = {
	FinishIdle = "finish_idle",
	Idle = "idle",
	Open = "open"
}
var_0_0.EpisodeGameFinishAnim = {
	Idle = "idle",
	Open = "open"
}
var_0_0.AttributeAnim = {
	Down = "down",
	Up = "up",
	Empty = "empty"
}
var_0_0.AttributeColor = {
	"#4B8964",
	"#508FB3",
	"#BF6639"
}
var_0_0.AttributeNotEnoughColor = "#B2B2B2"
var_0_0.AttributeDownColor = "#B7493C"
var_0_0.AttributeAnimRevertTime = 0.5
var_0_0.FinishStoryAnimDelayTime = 1.5
var_0_0.FinishGameAnimDelayTime = 1.5
var_0_0.PathAnimDelayTime = 0.5
var_0_0.UnlockAnimDelayTime = 1.7
var_0_0.FocusItemMoveDuration = 0.26
var_0_0.FinishAnimDelayTime = 0.6
var_0_0.FinishAnimDelayTimeEnd = 1.2

return var_0_0
