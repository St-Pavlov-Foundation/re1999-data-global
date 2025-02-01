module("modules.logic.activity.define.ActivityWarmUpEnum", package.seeall)

slot0 = _M
slot0.OrderStatus = {
	Accepted = 2,
	Finished = 4,
	Collected = 3,
	WaitForAccept = 1,
	None = 0
}
slot0.Quality2FramePath = {
	"bg_ka3",
	"bg_ka2",
	"bg_ka1"
}

return slot0
