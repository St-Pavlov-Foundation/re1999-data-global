module("modules.logic.versionactivity.model.VersionActivity112TaskListModel", package.seeall)

slot0 = class("VersionActivity112TaskListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.taskDic = {}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getActTask(slot0, slot1)
	if slot0.taskDic[slot1] == nil then
		slot0.taskDic[slot1] = {}

		for slot6, slot7 in ipairs(VersionActivityConfig.instance:getActTaskDicConfig(slot1)) do
			if slot7.isOnline == 1 then
				slot8 = VersionActivity112TaskMO.New()

				slot8:init(slot7)

				slot0.taskDic[slot1][slot7.taskId] = slot8
			end
		end
	end

	return slot0.taskDic[slot1]
end

function slot0.getTask(slot0, slot1, slot2)
	return slot0:getActTask(slot1)[slot2]
end

function slot0.refreshAlllTaskInfo(slot0, slot1, slot2)
	slot0.taskDic[slot1] = nil

	for slot6, slot7 in ipairs(slot2) do
		if slot0:getTask(slot1, slot7.taskId) then
			slot8:update(slot7)
		end
	end

	slot0:sortTaksList()
end

function slot0.updateTaskInfo(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if slot0:getTask(slot1, slot7.taskId) then
			slot8:update(slot7)
		end
	end

	slot0:sortTaksList()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112TaskUpdate)
end

function slot0.setGetBonus(slot0, slot1, slot2)
	if slot0:getTask(slot1, slot2) then
		slot3.hasGetBonus = true
	end

	slot0:sortTaksList()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112TaskGetBonus, slot2)
end

function slot0.sortTaksList(slot0)
	slot1 = slot0:getList()

	table.sort(slot1, uv0.sort)
	slot0:setList(slot1)
end

function slot0.updateTaksList(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:getActTask(slot1)) do
		if slot2 == (slot9.config.minTypeId == 1) then
			table.insert(slot4, slot9)
		end
	end

	table.sort(slot4, uv0.sort)
	slot0:setList(slot4)
end

function slot0.sort(slot0, slot1)
	if slot0.hasGetBonus ~= slot1.hasGetBonus then
		return slot1.hasGetBonus
	end

	if slot0:canGetBonus() ~= slot1:canGetBonus() then
		return slot2
	end

	return slot0.id < slot1.id
end

slot0.instance = slot0.New()

return slot0
