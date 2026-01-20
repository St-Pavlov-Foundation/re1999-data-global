-- chunkname: @modules/logic/sdk/config/SDKEfunChannelEventEnum.lua

module("modules.logic.sdk.config.SDKEfunChannelEventEnum", package.seeall)

local SDKEfunChannelEventEnum = _M

SDKEfunChannelEventEnum.EpisodePass = {
	[10103] = "finish_chap1.4",
	[10106] = "finish_chap1.7",
	[110101] = "finish_fight1",
	[10101] = "finish_chap1.1"
}
SDKEfunChannelEventEnum.PlayerLevelUp = {
	"upgradeRole_l1",
	"upgradeRole_l2",
	"upgradeRole_l3",
	nil,
	"upgradeRole_l5",
	nil,
	nil,
	nil,
	nil,
	"upgradeRole_l10",
	nil,
	nil,
	nil,
	nil,
	"upgradeRole_l15",
	[20] = "upgradeRole_l20"
}
SDKEfunChannelEventEnum.FirstSummon = "first_1draw"
SDKEfunChannelEventEnum.FirstPurchase = "firstpurchase"
SDKEfunChannelEventEnum.NickName = "name"
SDKEfunChannelEventEnum.Purchase = {
	[710001] = "BattlePass1",
	[610001] = "monthcard"
}
SDKEfunChannelEventEnum.TotalChargeAmount = {
	[999] = "rev9.99",
	[99] = "rev0.99",
	[9999] = "rev99.99",
	[4999] = "rev49.99",
	[2999] = "rev29.99"
}
SDKEfunChannelEventEnum.ConsumeItem = {}
SDKEfunChannelEventEnum.Summon = {
	[10] = "first_10draws"
}
SDKEfunChannelEventEnum.DailyTaskActive = {
	[16] = "daily_18"
}
SDKEfunChannelEventEnum.HeroRankUp = {}

return SDKEfunChannelEventEnum
