module("modules.logic.room.model.layout.RoomLayoutItemListModel", package.seeall)

slot0 = class("RoomLayoutItemListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot0._isBirthdayBlock = slot3 and true or false
	slot5, slot6 = slot0:_findBlockInfos(slot1)
	slot7 = slot0:_findbuildingInfos(slot2)

	for slot11, slot12 in pairs(slot5) do
		slot13 = RoomLayoutItemMO.New()

		slot13:init(#slot4 + 1, slot11, MaterialEnum.MaterialType.BlockPackage, slot12)
		table.insert(slot4, slot13)
	end

	for slot11, slot12 in ipairs(slot6) do
		slot13 = RoomLayoutItemMO.New()

		slot13:init(#slot4 + 1, slot12, MaterialEnum.MaterialType.SpecialBlock, 1)
		table.insert(slot4, slot13)
	end

	for slot11, slot12 in pairs(slot7) do
		for slot16 = 1, slot12 do
			slot17 = RoomLayoutItemMO.New()

			slot17:init(#slot4 + 1, slot11, MaterialEnum.MaterialType.Building, 1)

			slot17.itemIndex = slot16

			table.insert(slot4, slot17)
		end
	end

	table.sort(slot4, uv0.sortFuc)
	slot0:setList(slot4)
end

function slot0.resortList(slot0)
	slot1 = slot0:getList()

	table.sort(slot1, uv0.sortFuc)
	slot0:setList(slot1)
end

function slot0._findBlockInfos(slot0, slot1)
	slot2, slot3 = RoomLayoutHelper.findBlockInfos(slot1, slot0._isBirthdayBlock)

	return slot2, slot3
end

function slot0._findbuildingInfos(slot0, slot1)
	return RoomLayoutHelper.findbuildingInfos(slot1)
end

function slot0.sortFuc(slot0, slot1)
	if uv0._getLackOrder(slot0) ~= uv0._getLackOrder(slot1) then
		return slot2 < slot3
	end

	if uv0._getItemTypeOrder(slot0) ~= uv0._getItemTypeOrder(slot1) then
		return slot4 < slot5
	end

	if (slot0:getItemConfig().rare or 0) ~= (slot1:getItemConfig().rare or 0) then
		return slot9 < slot8
	end

	if slot0:isBlockPackage() and slot1:isBlockPackage() and slot0.itemNum ~= slot1.itemNum then
		return slot1.itemNum < slot0.itemNum
	end

	if slot0:isBuilding() and slot1:isBuilding() and slot6.buildDegree ~= slot7.buildDegree then
		return slot7.buildDegree < slot6.buildDegree
	end

	if slot0.itemId ~= slot1.itemId then
		return slot0.itemId < slot1.itemId
	end
end

function slot0._getLackOrder(slot0)
	if slot0:isLack() then
		return 1
	end

	return 2
end

function slot0._getItemTypeOrder(slot0)
	if slot0:isBlockPackage() then
		return 1
	elseif slot0:isSpecialBlock() then
		return 2
	elseif slot0:isBuilding() then
		return 3
	end

	return 100
end

slot0.instance = slot0.New()

return slot0
