module("modules.logic.room.model.trade.RoomWholesaleOrderMo", package.seeall)

slot0 = class("RoomWholesaleOrderMo")

function slot0.ctor(slot0)
	slot0.orderId = nil
	slot0.goodId = nil
	slot0.todaySoldCount = nil
	slot0.co = nil
end

function slot0.initMo(slot0, slot1)
	slot0.orderId = slot1.orderId
	slot0.goodId = slot1.goodId
	slot0.todaySoldCount = slot1.todaySoldCount
	slot0.co = ManufactureConfig.instance:getManufactureItemCfg(slot0.goodId)
	slot0.soldCount = RoomTradeModel.instance:isMaxWeelyOrder() and 0 or math.min(1, slot0:getMaxCount())
	slot0.itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot0.co.itemId)
end

function slot0.refreshTodaySoldCount(slot0, slot1)
	slot0.todaySoldCount = slot1
end

function slot0.getGoodsName(slot0)
	return slot0.itemCo and slot0.itemCo.name
end

function slot0.getGoodsIcon(slot0)
	return slot0.itemCo and slot0.itemCo.icon
end

function slot0.getMaxCount(slot0)
	return ManufactureModel.instance:getManufactureItemCount(slot0.goodId, false)
end

function slot0.getMaxCountStr(slot0)
	return GameUtil.numberDisplay(slot0:getMaxCount())
end

function slot0.getTodaySoldCount(slot0)
	return slot0.todaySoldCount
end

function slot0.getTodaySoldCountStr(slot0)
	return GameUtil.numberDisplay(slot0.todaySoldCount)
end

function slot0.getItem(slot0)
	if ManufactureConfig.instance:getManufactureItemCfg(slot0.goodId) then
		return MaterialEnum.MaterialType.Item, slot1.itemId
	end
end

function slot0.getUnitPrice(slot0)
	return MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomTrade, slot0.co.wholesalePrice
end

function slot0.getPriceRatio(slot0)
	slot1 = slot0.co.orderPrice

	return -math.floor((slot1 - slot0.co.wholesalePrice) / slot1 * 100 + 0.5)
end

function slot0.getSoldCount(slot0)
	return math.min(slot0:getMaxCount(), slot0.soldCount)
end

function slot0.getSoldCountStr(slot0)
	return GameUtil.numberDisplay(slot0:getSoldCount())
end

function slot0.addSoldCount(slot0, slot1)
	slot0.soldCount = slot0.soldCount + (slot1 or 1)
	slot0.soldCount = slot0:getSoldCount()
end

function slot0.reduceSoldCount(slot0, slot1)
	slot0.soldCount = slot0.soldCount - (slot1 or 1)
	slot0.soldCount = math.max(0, slot0.soldCount)
end

function slot0.setSoldCount(slot0, slot1)
	slot0.soldCount = GameUtil.clamp(slot1, 0, slot0:getMaxCount())
end

return slot0
