module("modules.logic.room.model.common.RoomStoreOrderModel", package.seeall)

slot0 = class("RoomStoreOrderModel", BaseModel)

function slot0.getMOByList(slot0, slot1)
	if slot1 and #slot1 > 0 then
		for slot6 = 1, #slot0:getList() do
			if slot2[slot6]:isSameValue(slot1) then
				return slot7
			end
		end
	end

	return nil
end

function slot0.addByStoreItemMOList(slot0, slot1, slot2, slot3)
	if not slot0:getById(slot2) then
		slot0:addAtLast(RoomStoreOrderMO.New())
	end

	slot8 = slot3

	slot4:init(slot2, slot8)

	for slot8 = 1, #slot1 do
		if slot1[slot8]:getCanBuyNum() > 0 then
			slot4:addValue(slot9.materialType, slot9.itemId, slot10)
		end
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
