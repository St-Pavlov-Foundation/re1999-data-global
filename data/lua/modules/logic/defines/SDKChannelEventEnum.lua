module("modules.logic.defines.SDKChannelEventEnum", package.seeall)

slot0 = _M
slot0.HeroGetEvent = {
	[3023] = SDKDataTrackMgr.ChannelEvent.stdhour1
}
slot0.PlayerLevelUpEvent = {
	[5] = SDKDataTrackMgr.ChannelEvent.stdlevel
}
slot0.HeroRankUp = {
	SDKDataTrackMgr.ChannelEvent.stdrechargeprompt,
	SDKDataTrackMgr.ChannelEvent.stdrecharge,
	SDKDataTrackMgr.ChannelEvent.stdmonthly
}
slot0.ConsumeItem = {
	[140001] = {
		100,
		SDKDataTrackMgr.ChannelEvent.stdstaminapurchase
	}
}
slot0.appReviewGuideId = 108
slot0.appReviewGuideStep = 8

return slot0
