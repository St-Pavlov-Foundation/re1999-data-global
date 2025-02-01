slot0 = pureTable("Activity104EquipComposeMo")

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.uid
	slot0.itemId = slot1.itemId
	slot0.originMO = slot1
end

return slot0
