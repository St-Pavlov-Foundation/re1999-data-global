module("modules.logic.room.model.common.RoomSkinListModel", package.seeall)

slot0 = class("RoomSkinListModel", ListScrollModel)

function slot1(slot0, slot1)
	if RoomConfig.instance:getRoomSkinPriority(slot0.id) ~= RoomConfig.instance:getRoomSkinPriority(slot1.id) then
		return slot5 < slot4
	end

	if RoomConfig.instance:getRoomSkinRare(slot2) ~= RoomConfig.instance:getRoomSkinRare(slot3) then
		return slot7 < slot6
	end

	return slot2 < slot3
end

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	slot0:_clearData()
	uv0.super.clear(slot0)
end

function slot0._clearData(slot0)
	slot0:_setSelectPartId()
	slot0:setCurPreviewSkinId()
end

function slot0._setSelectPartId(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._selectPartId = slot1
end

function slot0.setRoomSkinList(slot0, slot1)
	slot0:_setSelectPartId(slot1)

	slot3 = {}

	for slot8, slot9 in ipairs(RoomConfig.instance:getSkinIdList(slot0:getSelectPartId())) do
		slot3[#slot3 + 1] = {
			id = slot9
		}
	end

	table.sort(slot3, uv0)
	slot0:setList(slot3)
end

function slot0.setCurPreviewSkinId(slot0, slot1)
	slot0._curPreviewSkinId = slot1

	if not slot1 then
		return
	end

	slot2 = nil

	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8.id == slot1 then
			slot2 = slot8

			break
		end
	end

	for slot7, slot8 in ipairs(slot0._scrollViews) do
		slot8:setSelect(slot2)
	end
end

function slot0.getCurPreviewSkinId(slot0)
	return slot0._curPreviewSkinId
end

function slot0.getSelectPartId(slot0)
	return slot0._selectPartId
end

slot0.instance = slot0.New()

return slot0
