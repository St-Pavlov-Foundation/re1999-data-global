module("modules.logic.seasonver.act123.model.Season123TaskModel", package.seeall)

slot0 = class("Season123TaskModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.tempTaskModel = BaseModel.New()
	slot0.curTaskType = Activity123Enum.TaskRewardViewType
	slot0.stageTaskMap = {}
	slot0.normalTaskMap = {}
	slot0.reddotShowMap = {}
	slot0.curStage = 1
	slot0.TaskMaskTime = 0.65
	slot0.ColumnCount = 1
	slot0.AnimRowCount = 7
	slot0.OpenAnimTime = 0.06
	slot0.OpenAnimStartTime = 0
end

function slot0.reInit(slot0)
	slot0.tempTaskModel:clear()
end

function slot0.clear(slot0)
	slot0.tempTaskModel:clear()
	uv0.super.clear(slot0)

	slot0._itemStartAnimTime = nil
	slot0.stageTaskMap = {}
	slot0.normalTaskMap = {}
	slot0.reddotShowMap = {}
end

function slot0.resetMapData(slot0)
	slot0.stageTaskMap = {}
	slot0.normalTaskMap = {}
end

function slot0.setTaskInfoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot1) do
		if slot8.config and slot8.config.seasonId == Season123Model.instance:getCurSeasonId() then
			table.insert(slot2, slot8)
		end
	end

	slot0.tempTaskModel:setList(slot2)
	slot0:sortList()
	slot0:checkRedDot()

	for slot7, slot8 in pairs(slot0.tempTaskModel:getList()) do
		slot0:initTaskMap(slot8)
	end
end

function slot0.initTaskMap(slot0, slot1)
	if #Season123Config.instance:getTaskListenerParamCache(slot1.config) > 1 and slot1.config.isRewardView == Activity123Enum.TaskRewardViewType then
		if not slot0.stageTaskMap[tonumber(slot2[1])] then
			slot0.stageTaskMap[slot3] = {}
		end

		slot0.stageTaskMap[slot3][slot1.id] = slot1
	else
		slot0.normalTaskMap[slot1.id] = slot1
	end
end

function slot0.sortList(slot0)
	slot0.tempTaskModel:sort(uv0.sortFunc)
end

function slot0.sortFunc(slot0, slot1)
	if (slot0.config.maxFinishCount <= slot0.finishCount and 3 or slot0.hasFinished and 1 or 2) ~= (slot1.config.maxFinishCount <= slot1.finishCount and 3 or slot1.hasFinished and 1 or 2) then
		return slot2 < slot3
	elseif slot0.config.sortId ~= slot1.config.sortId then
		return slot0.config.sortId < slot1.config.sortId
	else
		return slot0.config.id < slot1.config.id
	end
end

function slot0.updateInfo(slot0, slot1)
	slot2 = false

	if GameUtil.getTabLen(slot0.tempTaskModel:getList()) == 0 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7.type == TaskEnum.TaskType.Season123 then
			if not slot0.tempTaskModel:getById(slot7.id) then
				if Season123Config.instance:getSeason123TaskCo(slot7.id) then
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

			slot2 = true
		end
	end

	if slot2 then
		slot0:sortList()
		slot0:checkRedDot()
	end

	return slot2
end

function slot0.refreshList(slot0, slot1)
	slot0.curTaskType = slot1 or slot0.curTaskType
	slot2 = {}

	for slot6, slot7 in pairs(slot0.tempTaskModel:getList()) do
		if #Season123Config.instance:getTaskListenerParamCache(slot7.config) > 1 and tonumber(slot8[1]) == slot0.curStage and slot7.config.isRewardView == slot0.curTaskType then
			table.insert(slot2, slot7)
		elseif slot7.config.isRewardView == Activity123Enum.TaskNormalType and slot7.config.isRewardView == slot0.curTaskType then
			table.insert(slot2, slot7)
		end
	end

	if slot0:getTaskItemRewardCount(slot0:checkAndRemovePreposeTask(slot2)) > 1 then
		table.insert(slot2, 1, {
			id = 0,
			canGetAll = true
		})
	end

	slot0:setList(slot2)
	slot0:saveCurStageAndTaskType()
	slot0:checkRedDot()
end

function slot0.getTaskItemRewardCount(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.config.maxProgress <= slot7.progress and slot7.finishCount == 0 then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.isTaskFinished(slot0, slot1)
	return slot1.finishCount > 0 and slot1.config.maxProgress <= slot1.progress
end

function slot0.checkRedDot(slot0)
	slot0.reddotShowMap[Activity123Enum.TaskRewardViewType] = slot0:checkTaskHaveReward(slot0.stageTaskMap[slot0.curStage])
	slot0.reddotShowMap[Activity123Enum.TaskNormalType] = slot0:checkTaskHaveReward(slot0.normalTaskMap)
end

function slot0.getAllCanGetList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList() or {}) do
		if slot7.config and slot7.config.maxProgress <= slot7.progress and slot7.finishCount == 0 then
			table.insert(slot1, slot7.id)
		end
	end

	return slot1
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

function slot0.getLocalKey(slot0)
	return "Season123Task" .. "#" .. tostring(Season123Model.instance:getCurSeasonId()) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.saveCurStageAndTaskType(slot0)
	PlayerPrefsHelper.setString(slot0:getLocalKey(), slot0.curStage .. "#" .. slot0.curTaskType)
end

function slot0.initStageAndTaskType(slot0)
	slot2 = string.splitToNumber(PlayerPrefsHelper.getString(slot0:getLocalKey(), 1 .. "#" .. Activity123Enum.TaskRewardViewType), "#")
	slot4 = slot2[2]
	slot7 = slot0:checkTaskHaveReward(slot0.normalTaskMap)

	if slot0:checkTaskHaveReward(slot0.stageTaskMap[#slot0:getHaveRewardTaskIndexList() > 0 and slot5[1] or slot2[1]]) then
		slot0.curTaskType = Activity123Enum.TaskRewardViewType
	elseif slot7 then
		slot0.curTaskType = Activity123Enum.TaskNormalType
	else
		slot0.curTaskType = slot4
	end

	slot0.curStage = slot6
end

function slot0.getHaveRewardTaskIndexList(slot0)
	slot1 = {}
	slot2 = {}

	for slot6 = 1, 6 do
		for slot11, slot12 in pairs(slot0.stageTaskMap[slot6] or {}) do
			if slot12.config.maxProgress <= slot12.progress and slot12.finishCount == 0 then
				table.insert(slot1, slot6)

				slot2[slot6] = true

				break
			end
		end
	end

	return slot1, slot2
end

function slot0.checkTaskHaveReward(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot5, slot6 in pairs(slot1) do
		if slot6.config.maxProgress <= slot6.progress and slot6.finishCount == 0 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
