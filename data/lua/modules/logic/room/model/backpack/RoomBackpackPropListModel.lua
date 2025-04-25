module("modules.logic.room.model.backpack.RoomBackpackPropListModel", package.seeall)

slot0 = class("RoomBackpackPropListModel", ListScrollModel)

function slot1(slot0, slot1)
	if not slot0 or not slot1 then
		return false
	end

	slot2 = slot0.id
	slot3 = slot1.id

	if slot0.config.rare ~= slot1.config.rare then
		return slot5.rare < slot4.rare
	end

	return slot3 < slot2
end

function slot0.onInit(slot0)
	slot0:clear()
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
end

function slot0.setBackpackPropList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ItemModel.instance:getItemList() or {}) do
		if ItemEnum.RoomBackpackPropSubType[ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot7.id) and slot8.subType] and slot0:_convert2PropItem(slot7) then
			table.insert(slot1, slot10)
		end
	end

	table.sort(slot1, uv0)
	slot0:setList(slot1)
end

function slot0._convert2PropItem(slot0, slot1)
	slot2 = nil
	slot4 = slot1 and slot1.quantity

	if ManufactureConfig.instance:getManufactureItemListByItemId(slot1 and slot1.id)[1] then
		slot4 = ManufactureModel.instance:getManufactureItemCount(slot6)
	end

	slot7 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot3)

	if slot3 and slot4 and slot4 > 0 and slot7 then
		slot2 = {
			type = MaterialEnum.MaterialType.Item,
			id = slot3,
			quantity = slot4,
			config = slot7
		}
	end

	return slot2
end

function slot0.isBackpackEmpty(slot0)
	return slot0:getCount() <= 0
end

slot0.instance = slot0.New()

return slot0
