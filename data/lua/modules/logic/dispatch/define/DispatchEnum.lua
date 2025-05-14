module("modules.logic.dispatch.define.DispatchEnum", package.seeall)

local var_0_0 = _M

var_0_0.DispatchStatus = {
	Finished = 3,
	NotDispatch = 1,
	Dispatching = 2
}
var_0_0.DispatchShortedType = {
	Career = 1,
	HeroId = 2
}
var_0_0.ActId2View = {
	[VersionActivity1_8Enum.ActivityId.Dungeon] = ViewName.VersionActivity1_8DispatchView
}

return var_0_0
