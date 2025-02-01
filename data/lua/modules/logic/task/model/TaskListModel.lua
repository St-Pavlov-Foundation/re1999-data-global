module("modules.logic.task.model.TaskListModel", package.seeall)

slot0 = class("TaskListModel", BaseModel)

function slot0.getTaskList(slot0, slot1)
	slot2 = {}
	slot3 = TaskModel.instance:getAllUnlockTasks(slot1)

	if slot1 == TaskEnum.TaskType.Novice then
		slot4 = TaskModel.instance:getCurStageAllLockTaskIds()
		slot6 = {}
		slot7 = {}
		slot8 = {}

		for slot12, slot13 in pairs(slot3) do
			if slot13.type == TaskEnum.TaskType.Novice then
				if slot13.config.stage == TaskModel.instance:getNoviceTaskCurStage() and slot13.config.minTypeId == TaskEnum.TaskMinType.Novice and JumpConfig.instance:isOpenJumpId(slot13.config.jumpId) then
					table.insert(slot2, slot13)
				end

				if slot13.config.minTypeId == TaskEnum.TaskMinType.GrowBack and JumpConfig.instance:isOpenJumpId(slot13.config.jumpId) and slot13.finishCount < slot13.config.maxFinishCount then
					table.insert(slot7, slot13)
				end
			end
		end

		for slot12, slot13 in ipairs(slot4) do
			if JumpConfig.instance:isOpenJumpId(slot0:fillLockTaskMo(slot13).config.jumpId) then
				table.insert(slot2, slot14)
			end
		end

		table.sort(slot2, function (slot0, slot1)
			if (slot0.config.maxFinishCount <= slot0.finishCount and 3 or slot0.hasFinished and 1 or 2) ~= (slot1.config.maxFinishCount <= slot1.finishCount and 3 or slot1.hasFinished and 1 or 2) then
				return slot2 < slot3
			elseif slot0.config.sortId ~= slot1.config.sortId then
				return slot0.config.sortId < slot1.config.sortId
			else
				return slot0.config.id < slot1.config.id
			end
		end)
		table.sort(slot7, function (slot0, slot1)
			return slot1.config.sortId < slot0.config.sortId
		end)

		for slot12, slot13 in ipairs(slot7) do
			table.insert(slot2, 1, slot13)
		end

		for slot12, slot13 in ipairs(slot0:_getCurMainTaskMo(slot3)) do
			if JumpConfig.instance:isOpenJumpId(slot13.config.jumpId) then
				table.insert(slot2, 1, slot13)
			end
		end
	else
		for slot7, slot8 in pairs(slot3) do
			if slot8.type == slot1 then
				slot9 = true

				if not string.nilorempty(slot8.config.prepose) then
					for slot14, slot15 in ipairs(string.split(slot8.config.prepose, "#")) do
						if not TaskModel.instance:isTaskFinish(slot8.type, tonumber(slot15)) then
							slot9 = false

							break
						end
					end
				end

				if slot9 then
					table.insert(slot2, slot8)
				end
			end
		end

		table.sort(slot2, function (slot0, slot1)
			if (slot0.config.maxFinishCount <= slot0.finishCount and 3 or slot0.hasFinished and 1 or 2) ~= (slot1.config.maxFinishCount <= slot1.finishCount and 3 or slot1.hasFinished and 1 or 2) then
				return slot2 < slot3
			elseif slot0.config.sortId ~= slot1.config.sortId then
				return slot0.config.sortId < slot1.config.sortId
			else
				return slot0.config.id < slot1.config.id
			end
		end)
	end

	return slot2
end

function slot0.fillLockTaskMo(slot0, slot1)
	return {
		typeId = 0,
		config = TaskConfig.instance:gettaskNoviceConfig(slot1),
		progress = 0,
		hasFinished = false,
		finishCount = 0,
		type = TaskEnum.TaskType.Novice,
		lock = true
	}
end

function slot0._getCurMainTaskMo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if slot7.type == TaskEnum.TaskType.Novice and slot7.config.chapter ~= 0 then
			table.insert(slot2, slot7)
		end
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.config.sortId < slot1.config.sortId
	end)

	for slot6, slot7 in ipairs(slot2) do
		if not slot7.config.prepose or slot7.config.prepose == "" then
			if not TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(slot7.id)) then
				return {
					slot7
				}
			end
		elseif not TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(slot7.config.id)) and TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(slot7.config.prepose)) then
			return {
				slot7
			}
		end
	end

	return {}
end

slot0.instance = slot0.New()

return slot0
