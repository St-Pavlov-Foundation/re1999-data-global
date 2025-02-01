module("modules.logic.room.model.common.RoomReportTypeListModel", package.seeall)

slot0 = class("RoomReportTypeListModel", ListScrollModel)

function slot0.sortFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.initType(slot0, slot1)
	table.sort(slot1, slot0.sortFunc)
	slot0:setList(slot1)
end

function slot0.setSelectId(slot0, slot1)
	if slot0.selectId == slot1 then
		return
	end

	slot0._selectId = slot1

	slot0:_refreshSelect()
end

function slot0.isSelect(slot0, slot1)
	return slot0._selectId == slot1
end

function slot0.getSelectId(slot0)
	return slot0._selectId
end

function slot0.clearSelect(slot0)
	slot0._selectId = nil
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectId))
	end
end

slot0.instance = slot0.New()

return slot0
