-- chunkname: @modules/logic/defines/SDKChannelEventEnum.lua

module("modules.logic.defines.SDKChannelEventEnum", package.seeall)

local SDKChannelEventEnum = _M

SDKChannelEventEnum.HeroGetEvent = {
	[3023] = SDKDataTrackMgr.ChannelEvent.stdhour1
}
SDKChannelEventEnum.PlayerLevelUpEvent = {
	[5] = SDKDataTrackMgr.ChannelEvent.stdlevel
}
SDKChannelEventEnum.HeroRankUp = {
	SDKDataTrackMgr.ChannelEvent.stdrechargeprompt,
	SDKDataTrackMgr.ChannelEvent.stdrecharge,
	SDKDataTrackMgr.ChannelEvent.stdmonthly
}
SDKChannelEventEnum.ConsumeItem = {
	[140001] = {
		100,
		SDKDataTrackMgr.ChannelEvent.stdstaminapurchase
	}
}
SDKChannelEventEnum.appReviewGuideId = 108
SDKChannelEventEnum.appReviewGuideStep = 8

return SDKChannelEventEnum
