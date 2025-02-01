module("modules.logic.sdk.config.SDKEfunChannelEventEnum", package.seeall)

slot0 = _M
slot0.EpisodePass = {
	[10103.0] = "finish_chap1.4",
	[10106.0] = "finish_chap1.7",
	[110101.0] = "finish_fight1",
	[10101.0] = "finish_chap1.1"
}
slot0.PlayerLevelUp = {
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
	[20.0] = "upgradeRole_l20"
}
slot0.FirstSummon = "first_1draw"
slot0.FirstPurchase = "firstpurchase"
slot0.NickName = "name"
slot0.Purchase = {
	[710001.0] = "BattlePass1",
	[610001.0] = "monthcard"
}
slot0.TotalChargeAmount = {
	[999.0] = "rev9.99",
	[99.0] = "rev0.99",
	[9999.0] = "rev99.99",
	[4999.0] = "rev49.99",
	[2999.0] = "rev29.99"
}
slot0.ConsumeItem = {}
slot0.Summon = {
	[10.0] = "first_10draws"
}
slot0.DailyTaskActive = {
	[16.0] = "daily_18"
}
slot0.HeroRankUp = {}

return slot0
