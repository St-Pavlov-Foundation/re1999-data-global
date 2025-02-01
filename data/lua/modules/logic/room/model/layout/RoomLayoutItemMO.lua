module("modules.logic.room.model.layout.RoomLayoutItemMO", package.seeall)

slot0 = pureTable("RoomLayoutItemMO")

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1
	slot0.itemId = slot2
	slot0.itemType = slot3
	slot0.materialType = slot3
	slot0.itemNum = slot4 or 1
	slot0.itemIndex = 1
end

function slot0.getItemQuantity(slot0)
	return ItemModel.instance:getItemQuantity(slot0.materialType, slot0.itemId) or 0
end

function slot0.getItemConfig(slot0)
	return ItemModel.instance:getItemConfig(slot0.materialType, slot0.itemId)
end

function slot0.getNeedNum(slot0)
	if slot0.materialType == MaterialEnum.MaterialType.BlockPackage or slot0.materialType == MaterialEnum.MaterialType.SpecialBlock then
		return 1
	end

	return slot0.itemNum
end

function slot0.isLack(slot0)
	if slot0:isBuilding() then
		slot1 = math.max(slot0:getNeedNum(), slot0.itemIndex)
	end

	return slot0:getItemQuantity() < slot1
end

function slot0.isBuilding(slot0)
	return slot0.materialType == MaterialEnum.MaterialType.Building
end

function slot0.isBlockPackage(slot0)
	return slot0.materialType == MaterialEnum.MaterialType.BlockPackage
end

function slot0.isSpecialBlock(slot0)
	return slot0.materialType == MaterialEnum.MaterialType.SpecialBlock
end

return slot0
