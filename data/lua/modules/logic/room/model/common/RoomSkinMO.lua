module("modules.logic.room.model.common.RoomSkinMO", package.seeall)

slot0 = pureTable("RoomSkinMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
end

function slot0.setIsEquipped(slot0, slot1)
	slot0._isEquipped = slot1
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.getBelongPartId(slot0)
	return RoomConfig.instance:getBelongPart(slot0.id)
end

function slot0.isUnlock(slot0)
	slot1 = false

	return RoomConfig.instance:getRoomSkinUnlockItemId(slot0.id) and slot2 ~= 0 and ItemModel.instance:getItemCount(slot2) > 0 or true
end

function slot0.isEquipped(slot0)
	return slot0._isEquipped
end

return slot0
