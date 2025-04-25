module("modules.logic.room.model.trade.RoomProductionMo", package.seeall)

slot0 = class("RoomProductionMo")

function slot0.ctor(slot0)
	slot0.productionId = nil
	slot0.quantity = nil
end

function slot0.initMo(slot0, slot1)
	slot0.productionId = slot1.productionId
	slot0.quantity = slot1.quantity or 0
	slot0.co = ManufactureConfig.instance:getManufactureItemCfg(slot0.productionId)
end

function slot0.getCurQuantity(slot0)
	return ManufactureModel.instance:getManufactureItemCount(slot0.productionId, false)
end

function slot0.isEnoughCount(slot0)
	slot1 = slot0:getCurQuantity() or 0

	return slot0.quantity <= slot1, slot1
end

function slot0.getQuantityStr(slot0)
	slot1 = "#a63838"
	slot2 = luaLang("room_trade_progress")
	slot3, slot4 = slot0:isEnoughCount()

	if slot3 then
		slot1 = "#220F04"
	elseif not slot0:isPlacedProduceBuilding() or slot0:checkProduceBuildingLevel() then
		slot1 = "#6F6F6F"
		slot2 = luaLang("room_trade_progress_wrong")
	end

	return GameUtil.getSubPlaceholderLuaLangThreeParam(slot2, slot1, GameUtil.numberDisplay(slot4), GameUtil.numberDisplay(slot0.quantity))
end

function slot0.isPlacedProduceBuilding(slot0)
	return ManufactureController.instance:checkPlaceProduceBuilding(slot0.productionId)
end

function slot0.checkProduceBuildingLevel(slot0)
	slot1, slot2 = ManufactureController.instance:checkProduceBuildingLevel(slot0.productionId)

	return slot1, slot2
end

function slot0.getItem(slot0)
	if slot0.co then
		return MaterialEnum.MaterialType.Item, slot0.co.itemId
	end
end

function slot0.getOrderPrice(slot0)
	return slot0:getOneOrderPrice() * slot0.quantity
end

function slot0.getOneOrderPrice(slot0)
	return slot0.co and slot0.co.orderPrice * (ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.OrderPriceMul) or 1) or 0
end

return slot0
