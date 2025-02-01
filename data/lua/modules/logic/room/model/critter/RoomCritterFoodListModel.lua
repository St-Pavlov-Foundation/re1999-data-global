module("modules.logic.room.model.critter.RoomCritterFoodListModel", package.seeall)

slot0 = class("RoomCritterFoodListModel", ListScrollModel)

function slot1(slot0, slot1)
	if not slot0 or not slot0.id or not (slot1 and slot1.id) then
		return false
	end

	if slot0.isFavorite ~= slot1.isFavorite then
		return slot4
	end

	if ItemModel.instance:getItemCount(slot2) ~= ItemModel.instance:getItemCount(slot3) then
		return slot7 < slot6
	end

	if ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot2).rare ~= ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot3).rare then
		return slot9.rare < slot8.rare
	end

	return slot2 < slot3
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

function slot0.setCritterFoodList(slot0, slot1)
	slot3 = {
		[slot7] = {
			id = slot9,
			isFavorite = CritterConfig.instance:isFavoriteFood(slot1, slot9)
		}
	}

	for slot7, slot8 in ipairs(ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.CritterFood)) do
		slot9 = slot8.id
	end

	table.sort(slot3, uv0)
	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
