-- chunkname: @modules/logic/sdk/config/SDKLongchengChannelEventEnum.lua

module("modules.logic.sdk.config.SDKLongchengChannelEventEnum", package.seeall)

local SDKLongchengChannelEventEnum = _M

SDKLongchengChannelEventEnum.EpisodePass = {}
SDKLongchengChannelEventEnum.PlayerLevelUp = {
	[5] = "stdlevel"
}
SDKLongchengChannelEventEnum.FirstSummon = "stdhour1"
SDKLongchengChannelEventEnum.FirstPurchase = "firstpurchase"
SDKLongchengChannelEventEnum.GetMaxRareHero = "stdhour3"
SDKLongchengChannelEventEnum.FirstBuyPower = "stdexhausted"
SDKLongchengChannelEventEnum.FirstExchangeDiamond = "stdlackofdiamonds"
SDKLongchengChannelEventEnum.AppReviewePisodeId = 10115
SDKLongchengChannelEventEnum.Purchase = {}
SDKLongchengChannelEventEnum.DailyTaskActive = {}
SDKLongchengChannelEventEnum.TotalChargeAmount = {}
SDKLongchengChannelEventEnum.ConsumeItem = {}
SDKLongchengChannelEventEnum.Summon = {
	[100] = "stdstaminapurchase"
}
SDKLongchengChannelEventEnum.HeroRankUp = {
	nil,
	"stdrechargeprompt",
	"stdrecharge",
	"stdmonthly"
}

return SDKLongchengChannelEventEnum
