module("modules.logic.tower.model.TowerTaskModel", package.seeall)

slot0 = class("TowerTaskModel", MixScrollModel)

function slot0.onInit(slot0)
	slot0.tempTaskModel = BaseModel.New()
	slot0.ColumnCount = 1
	slot0.OpenAnimTime = 0.06
	slot0.OpenAnimStartTime = 0
	slot0.AnimRowCount = 6

	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.tempTaskModel:clear()
	uv0.super.clear(slot0)

	slot0.limitTimeTaskMap = {}
	slot0.limitTimeTaskList = {}
	slot0.bossTaskMap = {}
	slot0.bossTaskList = {}
	slot0.reddotShowMap = {}
	slot0._itemStartAnimTime = nil

	slot0:cleanData()
end

function slot0.cleanData(slot0)
	slot0.curSelectToweId = 1
	slot0.curSelectTowerType = TowerEnum.TowerType.Limited
end

function slot0.setTaskInfoList(slot0, slot1)
	slot2 = {}
	slot0.limitTimeTaskMap = {}
	slot0.bossTaskMap = {}

	for slot6, slot7 in pairs(slot1) do
		if not slot7.config then
			if not TowerConfig.instance:getTowerTaskConfig(slot7.id) then
				logError("爬塔任务配置表id不存在,请检查: " .. tostring(slot7.id))
			end

			slot7:init(slot7, slot8)
		end

		table.insert(slot2, slot7)
	end

	slot0.tempTaskModel:setList(slot2)

	for slot6, slot7 in ipairs(slot0.tempTaskModel:getList()) do
		slot0:initTaskMap(slot7)
	end

	slot0:initTaskList()
	slot0:sortList()
	slot0:checkRedDot()
end

function slot0.initTaskMap(slot0, slot1)
	slot2 = slot1.config.taskGroupId
	slot4 = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(slot2)

	if TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(slot2) then
		if not slot0.bossTaskMap[slot3.towerId] then
			slot0.bossTaskMap[slot3.towerId] = {}
		end

		slot0.bossTaskMap[slot3.towerId][slot1.id] = slot1
	elseif slot4 then
		slot0.limitTimeTaskMap[slot1.id] = slot1
	end
end

function slot0.initTaskList(slot0)
	slot0.limitTimeTaskList = {}

	for slot4, slot5 in pairs(slot0.limitTimeTaskMap) do
		table.insert(slot0.limitTimeTaskList, slot5)
	end

	slot0.bossTaskList = {}

	for slot4, slot5 in pairs(slot0.bossTaskMap) do
		slot0.bossTaskList[slot4] = {}

		for slot9, slot10 in pairs(slot5) do
			table.insert(slot0.bossTaskList[slot4], slot10)
		end
	end
end

function slot0.sortList(slot0)
	if #slot0.limitTimeTaskList > 0 then
		table.sort(slot0.limitTimeTaskList, uv0.limitTimeSortFunc)
	end

	if tabletool.len(slot0.bossTaskList) > 0 then
		for slot4, slot5 in ipairs(slot0.bossTaskList) do
			table.sort(slot5, uv0.bossSortFunc)
		end
	end
end

function slot0.bossSortFunc(slot0, slot1)
	if (slot0.config.maxProgress <= slot0.finishCount and 3 or slot0.hasFinished and 1 or 2) ~= (slot1.config.maxProgress <= slot1.finishCount and 3 or slot1.hasFinished and 1 or 2) then
		return slot2 < slot3
	else
		return slot0.config.id < slot1.config.id
	end
end

function slot0.limitTimeSortFunc(slot0, slot1)
	if (slot0.finishCount >= 1 and slot0.config.maxProgress <= slot0.progress and 3 or slot0.hasFinished and 1 or 2) ~= (slot1.finishCount >= 1 and slot1.config.maxProgress <= slot1.progress and 3 or slot1.hasFinished and 1 or 2) then
		return slot2 < slot3
	else
		return slot0.config.id < slot1.config.id
	end
end

function slot0.updateTaskInfo(slot0, slot1)
	slot2 = false

	if GameUtil.getTabLen(slot0.tempTaskModel:getList()) == 0 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7.type == TaskEnum.TaskType.Tower then
			if not slot0.tempTaskModel:getById(slot7.id) then
				if TowerConfig.instance:getTowerTaskConfig(slot7.id) then
					slot8 = TaskMo.New()

					slot8:init(slot7, slot9)
					slot0.tempTaskModel:addAtLast(slot8)
					slot0:initTaskMap(slot8)
				else
					logError("Season123TaskCo by id is not exit: " .. tostring(slot7.id))
				end
			else
				slot8:update(slot7)
			end

			slot0:initTaskMap(slot8)

			slot2 = true
		end
	end

	if slot2 then
		slot0:initTaskList()
		slot0:sortList()
		slot0:checkRedDot()
	end

	return slot2
end

function slot0.checkRedDot(slot0)
	if tabletool.len(slot0.limitTimeTaskList) > 0 then
		slot0.reddotShowMap[TowerEnum.TowerType.Limited] = slot0:getTaskItemCanGetCount(slot0.limitTimeTaskList) > 0
	end

	if tabletool.len(slot0.bossTaskList) > 0 then
		slot0.reddotShowMap[TowerEnum.TowerType.Boss] = {}

		for slot4, slot5 in pairs(slot0.bossTaskList) do
			slot0.reddotShowMap[TowerEnum.TowerType.Boss][slot4] = slot0:getTaskItemCanGetCount(slot5) > 0
		end
	end
end

function slot0.canShowReddot(slot0, slot1, slot2)
	if slot1 == TowerEnum.TowerType.Limited then
		return slot0.reddotShowMap[slot1]
	else
		return slot0.reddotShowMap[slot1][slot2]
	end
end

function slot0.setCurSelectTowerTypeAndId(slot0, slot1, slot2)
	slot0.curSelectTowerType = slot1
	slot0.curSelectToweId = slot2
end

function slot0.refreshList(slot0, slot1)
	if slot0:getTaskItemCanGetCount(tabletool.copy(slot0:getCurTaskList(slot1) or {})) > 1 then
		table.insert(slot3, 1, {
			id = 0,
			canGetAll = true
		})
	end

	slot0:setList(slot3)
	slot0:checkRedDot()
	TowerController.instance:dispatchEvent(TowerEvent.TowerRefreshTask)
end

function slot0.getAllCanGetList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getCurTaskList() or {}) do
		if slot7.config and slot7.config.maxProgress <= slot7.progress and slot7.finishCount == 0 then
			table.insert(slot1, slot7.id)
		end
	end

	return slot1
end

function slot0.getCurTaskList(slot0, slot1)
	slot2 = {}
	slot0.curSelectTowerType = slot1 or slot0.curSelectTowerType

	if slot0.curSelectTowerType == TowerEnum.TowerType.Limited then
		slot2 = slot0.limitTimeTaskList
	elseif slot0.curSelectTowerType == TowerEnum.TowerType.Boss then
		slot2 = slot0.bossTaskList[slot0.curSelectToweId]
	end

	return slot2
end

function slot0.getTaskItemRewardCount(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.config.maxProgress <= slot7.progress then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getTaskItemCanGetCount(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		if slot7.config.maxProgress <= slot7.progress and slot7.finishCount == 0 then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getTaskItemFinishedCount(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		if slot0:isTaskFinished(slot7) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.isTaskFinished(slot0, slot1)
	return slot1.finishCount > 0 and slot1.config.maxProgress <= slot1.progress
end

function slot0.isTaskFinishedById(slot0, slot1)
	return slot0.tempTaskModel:getById(slot1) and slot2.config.maxProgress <= slot2.progress
end

function slot0.getDelayPlayTime(slot0, slot1)
	if slot1 == nil then
		return -1
	end

	if slot0._itemStartAnimTime == nil then
		slot0._itemStartAnimTime = Time.time + slot0.OpenAnimStartTime
	end

	if not slot0:getIndex(slot1) or slot3 > slot0.AnimRowCount * slot0.ColumnCount then
		return -1
	end

	if slot2 - slot0._itemStartAnimTime - (math.floor((slot3 - 1) / slot0.ColumnCount) * slot0.OpenAnimTime + slot0.OpenAnimStartTime) > 0.1 then
		return -1
	else
		return slot4
	end
end

function slot0.getTotalTaskRewardCount(slot0)
	slot1 = slot0.tempTaskModel:getList()

	return slot0:getTaskItemRewardCount(slot1), #slot1
end

function slot0.checkHasBossTask(slot0)
	for slot4, slot5 in pairs(slot0.bossTaskMap) do
		if tabletool.len(slot5) > 0 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
