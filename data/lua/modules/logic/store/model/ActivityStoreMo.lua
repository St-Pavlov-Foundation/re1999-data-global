module("modules.logic.store.model.ActivityStoreMo", package.seeall)

slot0 = pureTable("ActivityStoreMo")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1
	slot0.id = slot2.id
	slot0.config = ActivityStoreConfig.instance:getStoreConfig(slot1, slot0.id)

	slot0:updateData(slot2)
end

function slot0.updateData(slot0, slot1)
	slot0.buyCount = slot1.buyCount
end

return slot0
