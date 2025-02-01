module("modules.logic.activity.model.warmup.ActivityWarmUpTaskListModel", package.seeall)

slot0 = class("ActivityWarmUpTaskListModel", ListScrollModel)

function slot0.init(slot0, slot1)
	slot0._totalDict = slot0._totalDict or {}
	slot3 = Activity106Config.instance:getTaskByActId(slot1)
	slot4 = {}

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity106) ~= nil then
		for slot8, slot9 in ipairs(slot3) do
			if slot2[slot9.id] ~= nil then
				if not slot0._totalDict[slot10] then
					slot0._totalDict[slot10] = ActivityWarmUpTaskMO.New()
				end

				slot12:init(slot11, slot9)
				table.insert(slot4, slot12)
			end
		end

		table.sort(slot4, uv0.sortMO)
	end

	slot0._totalDatas = slot4

	slot0:groupByDay()
end

function slot0.sortMO(slot0, slot1)
	if slot0:alreadyGotReward() ~= slot1:alreadyGotReward() then
		return slot3
	elseif slot0:isFinished() ~= slot1:isFinished() then
		return slot4
	end

	return slot0.id < slot1.id
end

function slot0.setSelectedDay(slot0, slot1)
	slot0._selectDay = slot1
end

function slot0.updateDayList(slot0)
	if slot0._taskGroup[slot0:getSelectedDay()] then
		slot0:setList(slot1)
	end
end

function slot0.getSelectedDay(slot0)
	return slot0._selectDay
end

function slot0.groupByDay(slot0)
	slot0._taskGroup = {}

	if not slot0._totalDatas then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0._taskGroup[slot7] = slot0._taskGroup[slot6.config.openDay] or {}

		table.insert(slot0._taskGroup[slot7], slot6)
	end
end

function slot0.dayHasReward(slot0, slot1)
	if slot0._taskGroup[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			if not slot7:alreadyGotReward() and slot7:isFinished() then
				return true
			end
		end
	end

	return false
end

function slot0.release(slot0)
	slot0._totalDict = nil
	slot0._totalDatas = nil
	slot0._taskGroup = nil
end

slot0.instance = slot0.New()

return slot0
