module("modules.logic.advance.config.TestTaskConfig", package.seeall)

slot0 = class("TestTaskConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._taskConfigs = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"test_server_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	slot0._taskConfigs = slot2
end

function slot0.getTaskList(slot0)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}

	for slot4, slot5 in pairs(slot0._taskConfigs.configDict) do
		table.insert(slot0._task_list, slot5)
	end

	return slot0._task_list
end

slot0.instance = slot0.New()

return slot0
