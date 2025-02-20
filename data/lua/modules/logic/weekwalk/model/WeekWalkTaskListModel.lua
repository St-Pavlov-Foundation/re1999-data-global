module("modules.logic.weekwalk.model.WeekWalkTaskListModel", package.seeall)

slot0 = class("WeekWalkTaskListModel", ListScrollModel)

function slot0.setTaskRewardList(slot0, slot1)
	slot0._rewardList = slot1
end

function slot0.getTaskRewardList(slot0)
	return slot0._rewardList
end

function slot0.getLayerTaskMapId(slot0)
	return slot0._layerTaskMapId
end

function slot0.getSortIndex(slot0, slot1)
	return slot0._sortMap[slot1] or 0
end

function slot0._canGet(slot0, slot1)
	if uv0.instance:getTaskMo(slot1) then
		if slot2.hasFinished and not (lua_task_weekwalk.configDict[slot1].maxFinishCount <= slot2.finishCount) then
			return true
		end
	end
end

function slot0.getCanGetList(slot0)
	slot1 = {}
	slot6 = slot0

	for slot5, slot6 in ipairs(slot0.getList(slot6)) do
		if slot6.id and slot0:_canGet(slot6.id) then
			table.insert(slot1, slot6.id)
		end
	end

	return slot1
end

function slot0.checkPeriods(slot0, slot1)
	if string.nilorempty(slot1.periods) then
		return true
	end

	return WeekWalkModel.instance:getInfo() and (string.splitToNumber(slot1.periods, "#")[1] or 0) <= slot5.issueId and slot5.issueId <= (slot2[2] or 0)
end

function slot0.showLayerTaskList(slot0, slot1, slot2)
	slot0._layerTaskMapId = slot2
	slot3 = {}
	slot0._sortMap = {}
	slot4 = 1
	slot7 = tostring(lua_weekwalk.configDict[slot2].layer)

	for slot12, slot13 in ipairs(TaskConfig.instance:getWeekWalkTaskList(slot1)) do
		if (slot13.listenerParam == slot7 or slot13.listenerType == "WeekwalkBattle" and string.find(slot13.listenerParam, slot7)) and slot0:checkPeriods(slot13) then
			table.insert(slot3, slot13)

			slot0._sortMap[slot13] = slot4
			slot4 = slot4 + 1

			if slot0:_canGet(slot13.id) then
				slot5 = 0 + 1
			end
		end
	end

	table.sort(slot3, slot0._sort)

	if slot5 > 1 then
		table.insert(slot3, 1, {
			id = 0,
			isGetAll = true,
			minTypeId = slot1
		})
	end

	table.insert(slot3, {
		isDirtyData = true
	})
	slot0:setList(slot3)
end

function slot0.showTaskList(slot0, slot1, slot2)
	uv0._mapId = tostring(slot2)

	table.sort(TaskConfig.instance:getWeekWalkTaskList(slot1), slot0._sort)

	if slot0:canGetRewardNum(slot1) > 1 then
		table.insert({}, 1, {
			id = 0,
			isGetAll = true,
			minTypeId = slot1
		})
	end

	for slot9, slot10 in ipairs(slot3) do
		table.insert(slot4, slot10)
	end

	table.insert(slot4, {
		isDirtyData = true
	})
	slot0:setList(slot4)
end

function slot0.canGetRewardNum(slot0, slot1, slot2)
	slot3 = TaskConfig.instance:getWeekWalkTaskList(slot1)
	slot4 = 0
	slot5 = 0
	slot6 = nil

	if slot2 then
		slot6 = tostring(lua_weekwalk.configDict[slot2].layer)
	end

	for slot10, slot11 in ipairs(slot3) do
		if uv0.instance:getTaskMo(slot11.id) then
			slot14 = lua_task_weekwalk.configDict[slot11.id].maxFinishCount <= slot12.finishCount
			slot15 = slot12.hasFinished

			if (not slot6 or slot11.listenerParam == slot6 or slot11.listenerType == "WeekwalkBattle" and string.find(slot11.listenerParam, slot6)) and slot0:checkPeriods(slot11) then
				if not slot14 then
					slot5 = slot5 + 1
				end

				if slot15 and not slot14 then
					slot4 = slot4 + 1
				end
			end
		end
	end

	return slot4, slot5
end

function slot0.canGetReward(slot0, slot1)
	for slot6, slot7 in ipairs(TaskConfig.instance:getWeekWalkTaskList(slot1)) do
		if not uv0.instance:getTaskMo(slot7.id) then
			return false
		end

		if slot8.hasFinished and not (lua_task_weekwalk.configDict[slot7.id].maxFinishCount <= slot8.finishCount) then
			return true
		end
	end
end

function slot0._sort(slot0, slot1)
	slot3 = uv0.instance:_taskStatus(slot1)
	slot5 = slot1.listenerParam == uv0._mapId

	if slot0.listenerParam == uv0._mapId and not slot5 and uv0.instance:_taskStatus(slot0) ~= 3 then
		return true
	end

	if not slot4 and slot5 and slot3 ~= 3 then
		return false
	end

	if slot2 ~= slot3 then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0._taskStatus(slot0, slot1)
	slot3 = lua_task_weekwalk.configDict[slot1.id]

	if not uv0.instance:getTaskMo(slot1.id) or not slot3 then
		return 2
	end

	slot5 = slot2.hasFinished

	if slot3.maxFinishCount <= slot2.finishCount then
		return 3
	elseif slot5 then
		return 1
	end

	return 2
end

function slot0.hasFinished(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		if uv0.instance:getTaskMo(slot6.id) and slot7.hasFinished then
			return true
		end
	end
end

function slot0.updateTaskList(slot0)
	slot0._taskList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.WeekWalk)
end

function slot0.hasTaskList(slot0)
	return slot0._taskList
end

function slot0.getTaskMo(slot0, slot1)
	return slot0._taskList and slot0._taskList[slot1]
end

slot0.instance = slot0.New()

return slot0
