module("modules.logic.room.model.transport.RoomTransportCritterListModel", package.seeall)

slot0 = class("RoomTransportCritterListModel", ListScrollModel)

function slot0.setCritterList(slot0)
	slot1 = {}

	for slot6 = 1, #CritterModel.instance:getAllCritters() do
		if slot2[slot6] and slot7:isMaturity() then
			table.insert(slot1, slot7)
		end
	end

	slot0:setList(slot1)
end

function slot0.getSelect(slot0)
	return slot0._selectId
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectId))
	end
end

function slot0.setSelect(slot0, slot1)
	if slot0._selectId ~= slot1 then
		slot0._selectId = slot1

		slot0:_refreshSelect()
	end
end

slot0.instance = slot0.New()

return slot0
