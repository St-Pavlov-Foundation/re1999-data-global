module("modules.logic.room.model.layout.RoomLayoutListModel", package.seeall)

slot0 = class("RoomLayoutListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.init(slot0)
	slot1 = {}

	for slot7 = 0, RoomLayoutModel.instance:getMaxPlanCount() do
		if not slot2:getById(slot7) then
			slot8 = RoomLayoutMO.New()

			slot8:init(slot7)
			slot8:setName("name_" .. slot7)
			slot8:setEmpty(true)
		else
			slot8:setEmpty(false)
		end

		table.insert(slot1, slot8)
	end

	slot0:setList(slot1)
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

function slot0.refreshList(slot0)
	slot0:onModelUpdate()
end

function slot0.initScelect(slot0, slot1)
	slot2 = 0

	if slot1 == true then
		for slot7, slot8 in ipairs(slot0:getList()) do
			if slot8:isEmpty() then
				slot2 = slot8.id

				break
			end
		end
	end

	slot0:setSelect(slot2)
end

slot0.instance = slot0.New()

return slot0
