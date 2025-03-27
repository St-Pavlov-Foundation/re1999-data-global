module("modules.logic.store.model.StoreSkinChargeMo", package.seeall)

slot0 = pureTable("StoreSkinChargeMo")

function slot0.init(slot0, slot1, slot2)
	slot0.belongStoreId = slot1
	slot0.id = slot2.id
	slot0.buyCount = slot2.buyCount
	slot0.config = StoreConfig.instance:getChargeGoodsConfig(slot0.id)
end

function slot0.getSkinChargePrice(slot0)
	slot1, slot2 = nil

	if slot0.config then
		slot1 = slot0.config.price
		slot2 = slot0.config.originalCost
	end

	return slot1, slot2
end

function slot0.isSoldOut(slot0)
	return slot0.buyCount > 0
end

return slot0
