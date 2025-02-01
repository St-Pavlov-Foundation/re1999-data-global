module("modules.logic.backpack.model.ItemMo", package.seeall)

slot0 = pureTable("ItemMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.quantity = 0
	slot0.lastUseTime = 0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.itemId
	slot0.quantity = slot1.quantity
	slot0.lastUseTime = slot1.lastUseTime
	slot0.lastUpdateTime = slot1.lastUpdateTime
end

function slot0.initFromMaterialData(slot0, slot1)
	slot0.id = slot1.materilId
	slot0.quantity = slot1.quantity
	slot0.lastUseTime = nil
	slot0.lastUpdateTime = nil
end

return slot0
