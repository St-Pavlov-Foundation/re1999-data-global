module("modules.logic.task.model.TaskModel", package.seeall)

slot0 = class("TaskModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._taskMODict = {}
	slot0._taskActivityMODict = {}
	slot0._newTaskIdDict = {}
	slot0._curStage = 0
	slot0._taskList = {}
	slot0._hasTaskNoviceStageReward = false
	slot0._noviceTaskHeroParam = nil
end

function slot0.setHasTaskNoviceStageReward(slot0, slot1)
	slot0._hasTaskNoviceStageReward = slot1
end

function slot0.couldGetTaskNoviceStageReward(slot0)
	return slot0._hasTaskNoviceStageReward
end

function slot0.setTaskNoviceStageHeroParam(slot0, slot1)
	slot0._noviceTaskHeroParam = slot1
end

function slot0.getTaskNoviceStageParam(slot0)
	return slot0._noviceTaskHeroParam
end

function slot0.getTaskById(slot0, slot1)
	return slot0._taskList[slot1]
end

function slot0.getTaskMoList(slot0, slot1, slot2)
	if not slot0:getAllUnlockTasks(slot1) then
		return {}
	end

	for slot8, slot9 in pairs(slot4) do
		if slot9.config and slot9.config.activityId == slot2 then
			table.insert(slot3, slot9)
		end
	end

	return slot3
end

function slot0.getRefreshCount(slot0)
	return slot0._selectCount
end

function slot0.setRefreshCount(slot0, slot1)
	slot0._selectCount = slot1
end

function slot0.setTaskMOList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot0._taskMODict[slot7] = {}
	end

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			TaskMo.New():init(slot7, slot0:getTaskConfig(slot7.type, slot7.id))

			if not slot0._taskMODict[slot7.type] then
				slot0._taskMODict[slot7.type] = {}
			end

			slot0._taskMODict[slot7.type][slot7.id] = slot9
			slot0._taskList[slot7.id] = slot9
		end
	end
end

function slot0.onTaskMOChange(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if not (slot0._taskMODict[slot6.type] and slot0._taskMODict[slot6.type][slot6.id] or nil) then
				TaskMo.New():init(slot6, slot0:getTaskConfig(slot6.type, slot6.id))

				if not slot0._taskMODict[slot6.type] then
					slot0._taskMODict[slot6.type] = {}
				end

				slot0._taskMODict[slot6.type][slot6.id] = slot9
				slot0._taskList[slot6.id] = slot9
				slot0._newTaskIdDict[slot6.id] = true
			else
				slot7:update(slot6)
			end
		end
	end
end

function slot0.getTaskConfig(slot0, slot1, slot2)
	if TaskConfigGetDefine.instance:getTaskConfigFunc(slot1) then
		return slot3(slot2)
	end
end

function slot0.isTaskFinish(slot0, slot1, slot2)
	if not slot0._taskMODict[slot1] then
		return false
	end

	if not slot3[slot2] then
		return false
	end

	return slot4:isClaimed()
end

function slot0.taskHasFinished(slot0, slot1, slot2)
	if not slot0._taskMODict[slot1] then
		return false
	end

	if not slot3[slot2] then
		return false
	end

	return slot4:isFinished()
end

function slot0.isTaskUnlock(slot0, slot1, slot2)
	if not slot0._taskMODict[slot1] then
		return false
	end

	if not slot3[slot2] then
		return false
	end

	return slot4.id == slot2
end

function slot0.getAllUnlockTasks(slot0, slot1)
	return slot0._taskMODict[slot1] or {}
end

function slot0.setTaskActivityMOList(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if not slot0._taskActivityMODict[slot6.typeId] then
				slot8 = nil
				slot7 = TaskActivityMo.New()

				slot7:init(slot6, (slot6.defineId + 1 > 5 or TaskConfig.instance:gettaskactivitybonusCO(slot6.typeId, slot6.defineId + 1)) and TaskConfig.instance:gettaskactivitybonusCO(slot6.typeId, slot6.defineId))

				slot0._taskActivityMODict[slot6.typeId] = slot7
			else
				slot7:update(slot6)
			end
		end
	end
end

function slot0.onTaskActivityMOChange(slot0, slot1)
	if slot1 then
		slot2 = nil

		for slot6, slot7 in ipairs(slot1) do
			if not slot0._taskActivityMODict[slot7.typeId] then
				slot9 = nil
				slot10 = TaskActivityMo.New()

				if ((slot7.defineId + 1 > 5 or TaskConfig.instance:gettaskactivitybonusCO(slot7.typeId, slot7.defineId + 1)) and TaskConfig.instance:gettaskactivitybonusCO(slot7.typeId, slot7.defineId)) ~= nil then
					slot10:init(slot7, slot9)
				end

				table.insert(slot2 or {}, slot10)

				slot0._taskActivityMODict[slot7.typeId] = slot10
			else
				slot8:update(slot7)
			end
		end
	end
end

function slot0.deleteTask(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		for slot10, slot11 in pairs(slot0._taskMODict) do
			slot0._taskMODict[slot10][slot6] = nil
		end
	end
end

function slot0.clearNewTaskIds(slot0)
	slot0._newTaskIdDict = {}
end

function slot0.getNewTaskIds(slot0)
	return slot0._newTaskIdDict
end

function slot0.getTaskActivityMO(slot0, slot1)
	return slot0._taskActivityMODict[slot1]
end

function slot0.getNoviceTaskCurStage(slot0)
	if slot0._curStage == 0 then
		slot0._curStage = slot0:getNoviceTaskMaxUnlockStage()
	end

	return slot0._curStage
end

function slot0.setNoviceTaskCurStage(slot0, slot1)
	slot0._curStage = slot1
end

function slot0.setNoviceTaskCurSelectStage(slot0, slot1)
	slot0._curSelectStage = slot1
end

function slot0.getNoviceTaskCurSelectStage(slot0)
	return slot0._curSelectStage or slot0:getNoviceTaskCurStage()
end

function slot0.getStageRewardGetIndex(slot0)
	return slot0._taskActivityMODict[TaskEnum.TaskType.Novice].defineId
end

function slot0.getNoviceTaskMaxUnlockStage(slot0)
	slot1 = 0

	if slot0._taskMODict[TaskEnum.TaskType.Novice] then
		slot5 = TaskEnum.TaskType.Novice

		for slot5, slot6 in pairs(slot0._taskMODict[slot5]) do
			if slot6.config.minTypeId == TaskEnum.TaskMinType.Novice and slot1 < TaskConfig.instance:gettaskNoviceConfig(slot6.id).stage and slot6.config.chapter == 0 then
				slot1 = slot7
			end
		end
	end

	return slot1
end

function slot0.getCurStageActDotGetNum(slot0)
	if slot0:getNoviceTaskCurStage() == slot0:getMaxStage(TaskEnum.TaskType.Novice) and slot0._taskActivityMODict[TaskEnum.TaskType.Novice].gainValue == slot0:getAllTaskTotalActDot() then
		return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, slot2).needActivity
	end

	if not slot0._taskActivityMODict[TaskEnum.TaskType.Novice] then
		return 0
	end

	return slot0._taskActivityMODict[TaskEnum.TaskType.Novice].value - slot0._taskActivityMODict[TaskEnum.TaskType.Novice].gainValue
end

function slot0.getStageActDotGetNum(slot0, slot1)
	if slot0:getNoviceTaskCurStage() < slot1 then
		return 0
	end

	if slot1 < slot2 then
		return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, slot1).needActivity
	end

	return slot0:getCurStageActDotGetNum()
end

function slot0.getAllTaskTotalActDot(slot0)
	for slot6, slot7 in pairs(TaskConfig.instance:gettaskNoviceConfigs()) do
		slot1 = 0 + slot7.activity
	end

	return slot1
end

function slot0.getCurStageMaxActDot(slot0)
	return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, slot0._curStage) and slot1.needActivity or 0
end

function slot0.getStageMaxActDot(slot0, slot1)
	return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, slot1) and slot2.needActivity or 0
end

function slot0.getMaxStage(slot0, slot1)
	for slot8, slot9 in pairs(TaskConfig.instance:getTaskActivityBonusConfig(slot1)) do
		if (VersionValidator.instance:isInReviewing() and slot9.hideInVerifing == true) == false and 1 < slot9.id then
			slot2 = slot9.id
		end
	end

	return slot2
end

function slot0.getCurStageAllLockTaskIds(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(TaskConfig.instance:gettaskNoviceConfigs()) do
		if slot7.stage == slot0._curStage and slot7.minTypeId == 1 and slot7.chapter == 0 and not slot0:isTaskUnlock(TaskEnum.TaskType.Novice, slot7.id) then
			table.insert(slot1, slot7.id)
		end
	end

	return slot1
end

function slot0.getAllRewardUnreceivedTasks(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._taskMODict[slot1]) do
		if slot7:isClaimable() then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.isTypeAllTaskFinished(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getAllUnlockTasks(slot1)) do
		if not slot0:isTaskFinish(slot1, slot7.id) then
			return false
		end
	end

	return true
end

function slot0.isAllRewardGet(slot0, slot1)
	slot3 = uv0.instance:getTaskActivityMO(slot1)

	for slot8 = 1, #TaskConfig.instance:getTaskActivityBonusConfig(slot1) do
		slot4 = 0 + slot2[slot8].needActivity
	end

	return slot4 <= slot3.value
end

function slot0.isFinishAllNoviceTask(slot0)
	return slot2 == slot0:getMaxStage(TaskEnum.TaskType.Novice) and (slot0:getNoviceTaskCurStage() < slot0:getNoviceTaskMaxUnlockStage() and true or slot0:getCurStageMaxActDot() <= slot0:getCurStageActDotGetNum()) and slot0:isTypeAllTaskFinished(TaskEnum.TaskType.Novice)
end

function slot0.getTaskTypeExpireTime(slot0, slot1)
	slot2 = 0

	for slot7, slot8 in pairs(slot0:getAllUnlockTasks(slot1)) do
		if slot8.expiryTime > 0 then
			slot2 = slot8.expiryTime

			break
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
