-- chunkname: @modules/logic/store/defines/DecorateStoreEnum.lua

module("modules.logic.store.defines.DecorateStoreEnum", package.seeall)

local DecorateStoreEnum = _M

DecorateStoreEnum.DecorateViewType = {
	UnFold = 2,
	Fold = 1
}
DecorateStoreEnum.DecorateItemType = {
	MainScene = 3,
	BuildingVideo = 4,
	SelfCard = 5,
	Default = 0,
	SkinGift = 6,
	Icon = 1,
	Skin = 2
}
DecorateStoreEnum.DecorateType = {
	Old = 802,
	New = 801
}
DecorateStoreEnum.MaxBuyTipType = {
	Owned = 1,
	SoldOut = 2
}
DecorateStoreEnum.TagType = {
	SpecialSell = 1
}

return DecorateStoreEnum
