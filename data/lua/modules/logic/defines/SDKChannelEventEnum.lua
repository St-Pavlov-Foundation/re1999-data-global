module("modules.logic.defines.SDKChannelEventEnum", package.seeall)

local var_0_0 = _M

var_0_0.HeroGetEvent = {
	[3023] = SDKDataTrackMgr.ChannelEvent.stdhour1
}
var_0_0.PlayerLevelUpEvent = {
	[5] = SDKDataTrackMgr.ChannelEvent.stdlevel
}
var_0_0.HeroRankUp = {
	SDKDataTrackMgr.ChannelEvent.stdrechargeprompt,
	SDKDataTrackMgr.ChannelEvent.stdrecharge,
	SDKDataTrackMgr.ChannelEvent.stdmonthly
}
var_0_0.ConsumeItem = {
	[140001] = {
		100,
		SDKDataTrackMgr.ChannelEvent.stdstaminapurchase
	}
}
var_0_0.appReviewGuideId = 108
var_0_0.appReviewGuideStep = 8

return var_0_0
