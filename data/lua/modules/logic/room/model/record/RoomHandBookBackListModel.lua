module("modules.logic.room.model.record.RoomHandBookBackListModel", package.seeall)

slot0 = class("RoomHandBookBackListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(ItemModel.instance:getItemsBySubType(ItemEnum.SubType.UtmStickers)) do
		slot8 = RoomHandBookBackMo.New()

		slot8:init(slot7)
		table.insert(slot1, slot8)
	end

	slot3 = RoomHandBookBackMo.New()

	slot3:setEmpty()
	table.insert(slot1, slot3)
	table.sort(slot1, uv0.sort)

	slot4 = RoomHandBookModel.instance:getSelectMoBackGroundId()

	for slot8, slot9 in ipairs(slot1) do
		if slot4 and slot4 == slot9.id then
			slot0._selectIndex = slot8

			RoomHandBookBackModel.instance:setSelectMo(slot9)

			break
		elseif slot9:isEmpty() then
			slot0._selectIndex = slot8

			RoomHandBookBackModel.instance:setSelectMo(slot9)

			break
		end
	end

	slot0:setList(slot1)
end

function slot0.sort(slot0, slot1)
	if (slot0:checkIsUse() and 3 or slot0:isEmpty() and 2 or 1) ~= (slot1:checkIsUse() and 3 or slot1:isEmpty() and 2 or 1) then
		return slot3 < slot2
	else
		return slot0.id < slot1.id
	end
end

function slot0.getSelectIndex(slot0)
	return slot0._selectIndex or 1
end

slot0.instance = slot0.New()

return slot0
