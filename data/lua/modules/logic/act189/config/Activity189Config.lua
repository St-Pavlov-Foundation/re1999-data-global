module("modules.logic.act189.config.Activity189Config", package.seeall)

slot0 = string.format
slot1 = table.insert
slot2 = class("Activity189Config", BaseConfig)

function slot2.reqConfigNames(slot0)
	return {
		"activity189_const",
		"activity189_mlstring",
		"activity189",
		"activity189_task"
	}
end

function slot2.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity189_task" then
		slot0.__onlineTaskList = nil

		slot0:__init_activity189_task(slot2)
	end
end

function slot2.__init_activity189_task(slot0, slot1)
	if slot0.__onlineTaskList then
		return slot0.__onlineTaskList
	end

	if isDebugBuild then
		TaskConfig.instance:initReadTaskList(uv0("[logError] 189_运营改版活动.xlsx - export_任务"), {}, Activity189Enum.TaskTag, slot1)
	else
		TaskConfig.instance:initReadTaskList(nil, slot2, Activity189Enum.TaskTag, slot1)
	end

	slot0.__onlineTaskList = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if slot7.isOnline then
			uv1(slot0.__onlineTaskList, slot7)
		end
	end

	slot0.__readTasksTagTaskCoDict = slot2
end

function slot2.getSettingCO(slot0, slot1)
	return lua_activity189.configDict[slot1]
end

function slot2.getBonusList(slot0, slot1)
	return GameUtil.splitString2(slot0:getSettingCO(slot1).bonus, true) or {}
end

function slot2.getAllTaskList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.__onlineTaskList) do
		if slot7.activityId == slot1 then
			uv0(slot2, slot7)
		end
	end

	return slot2
end

function slot2.getTaskCO(slot0, slot1)
	return lua_activity189_task.configDict[slot1]
end

function slot2.getTaskCO_ReadTask(slot0, slot1)
	return slot0.__readTasksTagTaskCoDict[slot1] or {}
end

function slot2.getTaskCO_ReadTask_Tag(slot0, slot1, slot2)
	return slot0:getTaskCO_ReadTask(slot1)[slot2]
end

function slot2.getTaskCO_ReadTask_Tag_TaskId(slot0, slot1, slot2, slot3)
	return slot0:getTaskCO_ReadTask_Tag(slot1, slot2)[slot3]
end

function slot2.getTaskType(slot0)
	return TaskEnum.TaskType.Activity189
end

slot2.instance = slot2.New()

return slot2
