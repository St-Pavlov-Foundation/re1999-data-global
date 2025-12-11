module("modules.logic.roomfishing.define.FishingEnum", package.seeall)

local var_0_0 = _M

var_0_0.Const = {
	DefaultMapId = 1,
	FishingBuilding = 13120
}
var_0_0.ConstId = {
	MaxHasFishingCurrency = 17,
	ExchangeCostCurrency = 15,
	MaxCanGetShareRewardTimes = 4,
	FishOption = 13,
	GetFriendBonusMinCount = 5,
	StrangerPoint = 10,
	FishingActId = 19,
	FriendPoint = 9,
	UidInputCountLimit = 20,
	OneFishCost = 12,
	MaxExchangeCount = 1,
	PoolRefreshInterval = 18,
	MaxInFishingCount = 2,
	MyPoint = 11
}
var_0_0.FriendListTag = {
	UnFishing = 1,
	Fishing = 2
}
var_0_0.OtherPlayerBoatType = {
	Stranger = 2,
	Friend = 1
}
var_0_0.FishingProgressType = {
	Myself = 1,
	Other = 2
}

return var_0_0
