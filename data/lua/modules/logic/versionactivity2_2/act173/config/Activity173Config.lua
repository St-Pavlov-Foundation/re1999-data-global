module("modules.logic.versionactivity2_2.act173.config.Activity173Config", package.seeall)

slot0 = class("Activity173Config", BaseConfig)

function slot0.onInit(slot0)
	slot0._taskCfg = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity173_task",
		"act173_global_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity173_task" then
		slot0._taskCfg = slot2
	elseif slot1 == "act173_global_task" then
		slot0._globalTaskCo = slot2
	end
end

function slot0.getTaskConfig(slot0, slot1)
	return slot0._taskCfg.configDict[slot1]
end

function slot0.getAllOnlineTasks(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._taskCfg.configList) do
		if slot6.isOnline == 1 then
			table.insert(slot1, slot6)
		end
	end

	table.sort(slot1, slot0.onlineTaskSortFunc)

	return slot1
end

function slot0.onlineTaskSortFunc(slot0, slot1)
	if slot0.sortId ~= slot1.sortId then
		return slot0.sortId < slot1.sortId
	end

	return slot0.id < slot1.id
end

function slot0.getGlobalTaskStages(slot0)
	return slot0._globalTaskCo and slot0._globalTaskCo.configList
end

function slot0.getGlobalVisibleTaskStages(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._globalTaskCo.configList) do
		if slot6.isVisible == 1 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
