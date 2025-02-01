module("modules.logic.room.view.common.RoomStoreGoodsTipViewContainer", package.seeall)

slot0 = class("RoomStoreGoodsTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomStoreGoodsTipView.New())
	table.insert(slot1, RoomStroreGoodsTipViewBanner.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
		table.insert({
			CurrencyEnum.CurrencyType.FreeDiamondCoupon,
			23
		}, {
			isCurrencySprite = true,
			id = StoreEnum.NormalRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	if ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		table.insert(slot3, {
			isCurrencySprite = true,
			id = StoreEnum.TopRoomTicket,
			type = MaterialEnum.MaterialType.Item
		})
	end

	return {
		CurrencyView.New(slot3)
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(ViewName.RoomStoreGoodsTipView, nil, true)
end

return slot0
