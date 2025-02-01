module("modules.logic.store.model.StoreChargeGoodsMO", package.seeall)

slot0 = pureTable("StoreChargeGoodsMO")

function slot0.init(slot0, slot1, slot2)
	slot0.belongStoreId = slot1
	slot0.id = slot2.id
	slot0.buyCount = slot2.buyCount
	slot0.firstCharge = slot2.firstCharge
	slot0.config = StoreConfig.instance:getChargeGoodsConfig(slot0.id)
end

return slot0
