module("modules.logic.activity.define.ActivityWarmUpEnum", package.seeall)

local var_0_0 = _M

var_0_0.OrderStatus = {
	Accepted = 2,
	Finished = 4,
	Collected = 3,
	WaitForAccept = 1,
	None = 0
}
var_0_0.Quality2FramePath = {
	"bg_ka3",
	"bg_ka2",
	"bg_ka1"
}
var_0_0.Activity125TaskTag = {
	sum_help_npc = 1,
	perfect_win = 3,
	help_npc = 2
}

return var_0_0
