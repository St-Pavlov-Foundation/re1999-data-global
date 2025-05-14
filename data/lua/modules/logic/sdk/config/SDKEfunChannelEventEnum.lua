module("modules.logic.sdk.config.SDKEfunChannelEventEnum", package.seeall)

local var_0_0 = _M

var_0_0.EpisodePass = {
	[10103] = "finish_chap1.4",
	[10106] = "finish_chap1.7",
	[110101] = "finish_fight1",
	[10101] = "finish_chap1.1"
}
var_0_0.PlayerLevelUp = {
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
var_0_0.FirstSummon = "first_1draw"
var_0_0.FirstPurchase = "firstpurchase"
var_0_0.NickName = "name"
var_0_0.Purchase = {
	[710001] = "BattlePass1",
	[610001] = "monthcard"
}
var_0_0.TotalChargeAmount = {
	[999] = "rev9.99",
	[99] = "rev0.99",
	[9999] = "rev99.99",
	[4999] = "rev49.99",
	[2999] = "rev29.99"
}
var_0_0.ConsumeItem = {}
var_0_0.Summon = {
	[10] = "first_10draws"
}
var_0_0.DailyTaskActive = {
	[16] = "daily_18"
}
var_0_0.HeroRankUp = {}

return var_0_0
