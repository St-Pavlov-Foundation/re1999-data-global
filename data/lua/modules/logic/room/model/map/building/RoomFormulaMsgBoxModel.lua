module("modules.logic.room.model.map.building.RoomFormulaMsgBoxModel", package.seeall)

slot0 = class("RoomFormulaMsgBoxModel", ListScrollModel)

function slot0.setCostItemList(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		if slot0.type ~= slot1.type then
			return slot1.type == MaterialEnum.MaterialType.Currency
		end

		if ItemModel.instance:getItemConfig(slot0.type, slot0.id).rare ~= ItemModel.instance:getItemConfig(slot1.type, slot1.id).rare then
			return slot3.rare < slot2.rare
		elseif slot0.id ~= slot1.id then
			return slot0.id < slot1.id
		end
	end)
	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
