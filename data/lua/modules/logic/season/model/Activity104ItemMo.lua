slot0 = pureTable("Activity104ItemMo")

function slot0.ctor(slot0)
	slot0.uid = 0
	slot0.itemId = 0
	slot0.quantity = 0
end

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.itemId = slot1.itemId
	slot0.quantity = slot1.quantity
end

function slot0.reset(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.itemId = slot1.itemId
	slot0.quantity = slot1.quantity
end

return slot0
