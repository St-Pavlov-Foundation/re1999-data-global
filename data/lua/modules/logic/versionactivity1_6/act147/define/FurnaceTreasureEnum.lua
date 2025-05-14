module("modules.logic.versionactivity1_6.act147.define.FurnaceTreasureEnum", package.seeall)

local var_0_0 = _M

var_0_0.RareBgName = "v1a6_secretstore_rare"
var_0_0.DEFAULT_BUY_COUNT = 1
var_0_0.ActGoodsPool = {
	Great = 2,
	Normal = 1
}
var_0_0.Pool2GoodsId = {
	[var_0_0.ActGoodsPool.Normal] = "1#520001#1",
	[var_0_0.ActGoodsPool.Great] = "1#520002#1"
}
var_0_0.BeginnerViewSpinePlayData = "daoju#0#-1"
var_0_0.Pool2SpinePlayData = {
	[var_0_0.ActGoodsPool.Normal] = "bigai#0#-1",
	[var_0_0.ActGoodsPool.Great] = "kaigai#0"
}
var_0_0.StoreId2CostItem = {
	[150] = 21,
	[160] = 22,
	[111] = CurrencyEnum.CurrencyType.BlueSoul,
	[114] = CurrencyEnum.CurrencyType.OrangeSoul
}

return var_0_0
