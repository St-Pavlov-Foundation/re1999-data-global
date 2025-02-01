module("modules.logic.room.model.common.RoomThemeItemMO", package.seeall)

slot0 = pureTable("RoomThemeItemMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.itemId = slot1
	slot0.itemNum = slot2 or 0
	slot0.materialType = slot3
end

function slot0.getItemQuantity(slot0)
	return ItemModel.instance:getItemQuantity(slot0.materialType, slot0.id) or 0
end

function slot0.getItemConfig(slot0)
	return ItemModel.instance:getItemConfig(slot0.materialType, slot0.id)
end

return slot0
