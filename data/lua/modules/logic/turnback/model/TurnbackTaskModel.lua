module("modules.logic.turnback.model.TurnbackTaskModel", package.seeall)

slot0 = class("TurnbackTaskModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.tempTaskModel = BaseModel.New()
	slot0.taskLoopTypeDotDict = {}
end

function slot0.reInit(slot0)
	slot0.tempTaskModel:clear()

	slot0.taskLoopTypeDotDict = {}
end

function slot0.setTaskInfoList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if TurnbackConfig.instance:getTurnbackTaskCo(slot7.id) then
			slot9 = TaskMo.New()

			slot9:init(slot7, slot8)
			table.insert(slot2, slot9)
		end
	end

	slot0.tempTaskModel:setList(slot2)
	slot0:sortList()
	slot0:checkTaskLoopTypeDotState()
end

function slot0.sortList(slot0)
	slot0.tempTaskModel:sort(function (slot0, slot1)
		if (slot0.finishCount > 0 and 3 or slot0.config.maxProgress <= slot0.progress and 1 or 2) == (slot1.finishCount > 0 and 3 or slot1.config.maxProgress <= slot1.progress and 1 or 2) then
			if slot0.config.sortId == slot1.config.sortId then
				return slot0.id < slot1.id
			else
				return slot0.config.sortId < slot1.config.sortId
			end
		else
			return slot2 < slot3
		end
	end)
end

function slot0.updateInfo(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot1) do
		if slot7.type == TaskEnum.TaskType.Turnback then
			if not slot0.tempTaskModel:getById(slot7.id) then
				if TurnbackConfig.instance:getTurnbackTaskCo(slot7.id) then
					slot8 = TaskMo.New()

					slot8:init(slot7, slot9)
					slot0.tempTaskModel:addAtLast(slot8)
				else
					logError("TurnbackTaskConfig by id is not exit: " .. tostring(slot7.id))
				end
			else
				slot8:update(slot7)
			end

			slot2 = true
		end
	end

	if slot2 then
		slot0:sortList()
		slot0:checkTaskLoopTypeDotState()
	end

	return slot2
end

function slot0.checkTaskLoopTypeDotState(slot0)
	for slot4, slot5 in pairs(slot0.taskLoopTypeDotDict) do
		slot0.taskLoopTypeDotDict[slot4] = false
	end

	for slot4, slot5 in ipairs(slot0.tempTaskModel:getList()) do
		if slot5.config.maxProgress <= slot5.progress and slot5.finishCount == 0 then
			slot0.taskLoopTypeDotDict[slot5.config.loopType] = true
		end
	end
end

function slot0.getTaskLoopTypeDotState(slot0)
	return slot0.taskLoopTypeDotDict
end

function slot0.refreshList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.tempTaskModel:getList()) do
		if slot7.config.loopType == slot1 and slot7.config.turnbackId == TurnbackModel.instance:getCurTurnbackId() then
			slot0.curTaskLoopType = slot1

			table.insert(slot2, slot7)
		end
	end

	slot0:setList(slot0:checkAndRemovePreposeTask(slot2))
	slot0:checkTaskLoopTypeDotState()
end

function slot0.getCurTaskLoopType(slot0)
	return slot0.curTaskLoopType or TurnbackEnum.TaskLoopType.Day
end

function slot0.haveTaskItemReward(slot0)
	for slot4, slot5 in ipairs(slot0.tempTaskModel:getList()) do
		if slot5.config.maxProgress <= slot5.progress and slot5.finishCount == 0 then
			return true
		end
	end

	return false
end

function slot0.isTaskFinished(slot0, slot1)
	return slot1.finishCount > 0 and slot1.config.maxProgress <= slot1.progress
end

function slot0.checkAndRemovePreposeTask(slot0, slot1)
	for slot6, slot7 in ipairs(tabletool.copy(slot1)) do
		for slot12, slot13 in ipairs(string.split(slot7.config.prepose, "#")) do
			if slot0.tempTaskModel:getById(tonumber(slot13)) and not slot0:isTaskFinished(slot14) then
				table.remove(slot2, slot6)

				break
			end
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
