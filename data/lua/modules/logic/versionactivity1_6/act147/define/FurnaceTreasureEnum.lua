module("modules.logic.versionactivity1_6.act147.define.FurnaceTreasureEnum", package.seeall)

slot0 = _M
slot0.RareBgName = "v1a6_secretstore_rare"
slot0.DEFAULT_BUY_COUNT = 1
slot0.ActGoodsPool = {
	Great = 2,
	Normal = 1
}
slot0.Pool2GoodsId = {
	[slot0.ActGoodsPool.Normal] = "1#520001#1",
	[slot0.ActGoodsPool.Great] = "1#520002#1"
}
slot0.BeginnerViewSpinePlayData = "daoju#0#-1"
slot0.Pool2SpinePlayData = {
	[slot0.ActGoodsPool.Normal] = "bigai#0#-1",
	[slot0.ActGoodsPool.Great] = "kaigai#0"
}
slot0.StoreId2CostItem = {
	[150.0] = 21,
	[160.0] = 22,
	[111] = CurrencyEnum.CurrencyType.BlueSoul,
	[114] = CurrencyEnum.CurrencyType.OrangeSoul
}

return slot0
