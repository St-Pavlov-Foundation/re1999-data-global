module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskModel", package.seeall)

slot0 = class("Activity114TaskModel", ListScrollModel)

function slot0.onGetTaskList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = Activity114TaskMo.New()

		slot8:update(slot7)
		table.insert(slot2, slot8)
	end

	table.sort(slot2, slot0.sortFunc)
	slot0:setList(slot2)
end

function slot0.sortFunc(slot0, slot1)
	if slot0.finishStatus == slot1.finishStatus then
		return slot0.config.taskId < slot1.config.taskId
	else
		return slot0.finishStatus < slot1.finishStatus
	end
end

function slot0.onTaskListUpdate(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot0:getById(slot7.taskId) then
			slot8:update(slot7)
		else
			slot9 = Activity114TaskMo.New()

			slot9:update(slot7)
			slot0:addAtLast(slot9)
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot0:getById(slot7.taskId) then
			slot0:remove(slot8)
		end
	end

	slot0:sort(slot0.sortFunc)
end

slot0.instance = slot0.New()

return slot0
