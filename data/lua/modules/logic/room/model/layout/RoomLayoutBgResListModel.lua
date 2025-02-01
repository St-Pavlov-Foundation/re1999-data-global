module("modules.logic.room.model.layout.RoomLayoutBgResListModel", package.seeall)

slot0 = class("RoomLayoutBgResListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.init(slot0, slot1)
	slot2 = {}

	for slot7 = 1, #RoomConfig.instance:getPlanCoverConfigList() do
		slot9 = slot3[slot7]

		RoomLayoutBgResMO.New():init(slot9.id, slot9)

		if slot9.id == slot1 then
			table.insert(slot2, 1, slot8)
		else
			table.insert(slot2, slot8)
		end
	end

	slot0._selectId = nil

	slot0:setList(slot2)
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectId))
	end
end

function slot0.getSelectMO(slot0)
	return slot0:getById(slot0._selectId)
end

function slot0.setSelect(slot0, slot1)
	slot0._selectId = slot1

	slot0:_refreshSelect()
end

slot0.instance = slot0.New()

return slot0
