module("modules.logic.season.model.Activity104TaskModel", package.seeall)

slot0 = class("Activity104TaskModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.getTaskSeasonList(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season)) do
		if slot7.config then
			table.insert(slot1, slot7)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if (slot0.config.maxFinishCount <= slot0.finishCount and 3 or slot0.hasFinished and 1 or 2) ~= (slot1.config.maxFinishCount <= slot1.finishCount and 3 or slot1.hasFinished and 1 or 2) then
			return slot2 < slot3
		elseif slot0.config.sortId ~= slot1.config.sortId then
			return slot0.config.sortId < slot1.config.sortId
		else
			return slot0.config.id < slot1.config.id
		end
	end)

	return slot1
end

slot0.instance = slot0.New()

return slot0
