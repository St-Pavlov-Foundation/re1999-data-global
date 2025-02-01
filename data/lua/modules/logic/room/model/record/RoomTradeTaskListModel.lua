module("modules.logic.room.model.record.RoomTradeTaskListModel", package.seeall)

slot0 = class("RoomTradeTaskListModel", ListScrollModel)

function slot0.setMoList(slot0, slot1)
	if LuaUtil.tableNotEmpty(RoomTradeTaskModel.instance:getLevelTaskMo(slot1) or {}) then
		table.sort(slot2, slot0.sort)
	end

	slot0:setList(slot2)

	return slot2
end

function slot0.sort(slot0, slot1)
	slot2 = slot0.co
	slot3 = slot1.co

	if slot0.hasFinish ~= slot1.hasFinish then
		return slot1.hasFinish
	end

	if slot2 and slot3 then
		return slot2.sortId < slot3.sortId
	end

	return slot0.id < slot1.id
end

function slot0.getNewFinishTaskIds(slot0, slot1)
	slot2 = {}

	if RoomTradeTaskModel.instance:getLevelTaskMo(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if slot8.new then
				table.insert(slot2, slot8.id)
			end
		end
	end

	return slot2
end

function slot0.getFinishOrNotTaskIds(slot0, slot1, slot2)
	slot3 = {}

	if RoomTradeTaskModel.instance:getLevelTaskMo(slot1) then
		for slot8, slot9 in ipairs(slot4) do
			if slot9:isFinish() == slot2 then
				table.insert(slot3, slot9.id)
			end
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
