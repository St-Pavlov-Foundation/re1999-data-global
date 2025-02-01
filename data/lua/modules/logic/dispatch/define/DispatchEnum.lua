module("modules.logic.dispatch.define.DispatchEnum", package.seeall)

slot0 = _M
slot0.DispatchStatus = {
	Finished = 3,
	NotDispatch = 1,
	Dispatching = 2
}
slot0.DispatchShortedType = {
	Career = 1,
	HeroId = 2
}
slot0.ActId2View = {
	[VersionActivity1_8Enum.ActivityId.Dungeon] = ViewName.VersionActivity1_8DispatchView
}

return slot0
