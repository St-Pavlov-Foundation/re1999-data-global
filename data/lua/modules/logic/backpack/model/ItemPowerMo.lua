module("modules.logic.backpack.model.ItemPowerMo", package.seeall)

slot0 = pureTable("ItemPowerMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.uid = 0
	slot0.quantity = 0
	slot0.expireTime = 0
end

function slot0.init(slot0, slot1)
	slot0.id = tonumber(slot1.itemId)
	slot0.uid = tonumber(slot1.uid)
	slot0.quantity = tonumber(slot1.quantity)
	slot0.expireTime = slot1.expireTime
end

function slot0.reset(slot0, slot1)
	slot0.id = tonumber(slot1.itemId)
	slot0.uid = tonumber(slot1.uid)
	slot0.quantity = tonumber(slot1.quantity)
	slot0.expireTime = slot1.expireTime
end

return slot0
