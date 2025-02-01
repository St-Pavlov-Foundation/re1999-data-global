module("modules.logic.achievement.model.mo.AchievementListMO", package.seeall)

slot0 = pureTable("AchievementListMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.taskCfgs = AchievementConfig.instance:getTasksByAchievementId(slot1)

	slot0:buildTaskStateMap()

	slot0.isFold = false
	slot0.isGroupTop = slot2
end

function slot0.buildTaskStateMap(slot0)
	slot0._unlockTaskList = {}
	slot0._loackTaskList = {}

	if slot0.taskCfgs then
		for slot4, slot5 in ipairs(slot0.taskCfgs) do
			if AchievementModel.instance:isAchievementTaskFinished(slot5.id) then
				table.insert(slot0._unlockTaskList, slot5)
			else
				table.insert(slot0._loackTaskList, slot5)
			end
		end
	end
end

function slot0.getTaskListBySearchFilterType(slot0, slot1)
	if (slot1 or AchievementEnum.SearchFilterType.All) == AchievementEnum.SearchFilterType.All then
		return slot0.taskCfgs
	elseif slot1 == AchievementEnum.SearchFilterType.Locked then
		return slot0._loackTaskList
	else
		return slot0._unlockTaskList
	end
end

function slot0.getTotalTaskConfigList(slot0)
	return slot0.taskCfgs
end

function slot0.getLockTaskList(slot0)
	return slot0._loackTaskList
end

function slot0.getUnlockTaskList(slot0)
	return slot0._unlockTaskList
end

function slot0.getFilterTaskList(slot0, slot1, slot2)
	slot1 = slot1 or AchievementEnum.SortType.RareDown

	if slot0:getTaskListBySearchFilterType(slot2 or AchievementEnum.SearchFilterType.All) then
		table.sort(slot3, slot0.sortTaskFunction)
	end

	return slot3
end

function slot0.sortTaskFunction(slot0, slot1)
	slot2 = AchievementModel.instance:isAchievementTaskFinished(slot0.id)
	slot3 = AchievementModel.instance:isAchievementTaskFinished(slot1.id)

	return slot0.id < slot1.id
end

function slot0.isAchievementMatch(slot0, slot1, slot2)
	slot3 = false

	return slot1 == AchievementEnum.AchievementType.Single and slot2 == slot0.id or AchievementConfig.instance:getAchievement(slot0.id) and slot4.groupId ~= 0 and slot4.groupId == slot2
end

function slot0.setIsFold(slot0, slot1)
	slot0.isFold = slot1
end

function slot0.getIsFold(slot0)
	return slot0.isFold
end

slot1 = 46
slot2 = 74
slot3 = 206

function slot0.getLineHeightFunction(slot0, slot1, slot2)
	slot3 = 0

	return slot2 and (slot0:getAchievementType() == AchievementEnum.AchievementType.Group and (slot0.isGroupTop and uv0 or 0) or uv1) or (slot0:getTaskListBySearchFilterType(slot1) and #slot6 or 0) * uv2 + (slot0.isGroupTop and uv0 + uv1 or uv1)
end

function slot0.overrideLineHeight(slot0, slot1)
	slot0._cellHeight = slot1
end

function slot0.clearOverrideLineHeight(slot0)
	slot0._cellHeight = nil
end

function slot0.getLineHeight(slot0, slot1, slot2)
	if slot0._cellHeight then
		return slot0._cellHeight
	end

	return slot0:getLineHeightFunction(slot1, slot2)
end

function slot0.getAchievementType(slot0)
	if not slot0._achievementType then
		slot0._achievementType = AchievementConfig.instance:getAchievement(slot0.id) and slot1.groupId ~= 0 and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
	end

	return slot0._achievementType
end

return slot0
